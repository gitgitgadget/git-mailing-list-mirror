From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Tracking file metadata in git -- fix metastore or enhance git?
Date: Fri, 8 Apr 2011 13:59:24 -0500
Message-ID: <20110408185924.GA25840@elie>
References: <BANLkTikkb3DUOtP9NUtNMNV5Z+oJ7AFHfg@mail.gmail.com>
 <Pine.BSM.4.64L.1104071923580.4692@herc.mirbsd.org>
 <BANLkTink-c8JuxnMBCAmXiVwFkBxJrTucw@mail.gmail.com>
 <4D9EDCEA.9010903@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Hartmann <richih.mailinglist@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>, Git List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 08 20:59:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8Gu9-0004i5-Fk
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 20:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580Ab1DHS7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 14:59:32 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58614 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757541Ab1DHS7b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 14:59:31 -0400
Received: by vws1 with SMTP id 1so2917926vws.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 11:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=H3VIhA+pKj65mUjkyfUON5TJXoqsGSp9YtTphDXJsqo=;
        b=b9KS7qlgzSXBfuq5CyN0cIg8Beip8e3IW+1u1A5WdFEWZSuAd1aP7stO1GI9UKzP9z
         WxvIIZ6e3cSyyJSF+OJqAYqo0vjSaIUFb1p1TMSSJj6S9lK87imKuRz/ihEr/WkNuj3+
         86B1ZXDXF7b0pKsLxI9sD4F0fb1sSUZt5QPPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HOdys4JD/bbIIUYi3qGde+EQJx7f3Zn6azaoeW+1XhB/a+zfXbC8w7c8S59LEnoB9Y
         vKtVDwZSbliKz0NIwhZlIt+SaYVle+8lA2IAwIYW6avxLhc8GesOToj1gCbcb4wkGb20
         yLNMnheXG5I5vmHhPt2mr6bB3Vfx3pbAhD4+Q=
Received: by 10.52.71.97 with SMTP id t1mr3756440vdu.246.1302289171223;
        Fri, 08 Apr 2011 11:59:31 -0700 (PDT)
Received: from elie (adsl-69-209-53-77.dsl.chcgil.ameritech.net [69.209.53.77])
        by mx.google.com with ESMTPS id c8sm727174vcc.33.2011.04.08.11.59.28
        (version=SSLv3 cipher=OTHER);
        Fri, 08 Apr 2011 11:59:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D9EDCEA.9010903@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171144>

Hi,

Michael J Gruber wrote:

> Note that etckeeper and metastore predate our notes feature. By now, a
> notes tree is a perfect place to store meta information. You can attach
> notes to blobs perfectly (see textconv-cache). That may be an option for
> a reimplementation, depending on how you want the versioning of the
> files to be related with the versioning of the meta data.

Wouldn't that mean the same content couldn't have one owner in one
commit and a different owner in another commit?

I think the most native-looking way to store metadata associated to
paths is .gitattributes.  It also has the nice feature of allowing a
single attribute to apply to multiple files.  But the tools for
looking them up (e.g., git check-attr) do not get much use yet so they
probably could use a lot of improvement.
