From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 7/7] web--browse: look at the BROWSER env var
Date: Fri, 3 Dec 2010 11:16:28 -0600
Message-ID: <20101203171628.GA13721@burratino>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291394861-11989-8-git-send-email-giuseppe.bilotta@gmail.com>
 <20101203170800.GE12910@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 18:16:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POZFb-0007Qj-G1
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 18:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542Ab0LCRQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 12:16:46 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37187 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab0LCRQp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 12:16:45 -0500
Received: by vws16 with SMTP id 16so1832545vws.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 09:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bQZ1UiFYeIdRfbssATZcfrQs59cZ7uF5m++pp+dpCkA=;
        b=UfGuFagzJ1AJr7z/fr4xhD1g4Wc6ZMcK/rQtLLeLx2H7Ti/rXAHIiEXiqtRY7xI/1W
         vO7gXcWgclZs7YAkiJUQStDd0pP22Ugtqt/d3Ep1Ba+jyRgmbE97+YAjcXpg0lR+LdWE
         pJqlSwAEdNLMGorpAxgIi86kOa3fsWkIppixk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MI1/7N5OwdNRd6K/XhR3hV2+qPQP0iS+cJGIJ7LVV7T+JLcqz19Gy/WjCKU+TgkFnU
         jBA0Hsoa6x5x5FAE0VYAVyB9lGYMNtZ+AD7hloaguVjbBMZCROS6K88ziLfFtLq5XuNm
         ZauWupTgWpuJ3rrzvqa+PNZYCZ+R8+Yt7Eh6U=
Received: by 10.220.121.162 with SMTP id h34mr483775vcr.13.1291396605173;
        Fri, 03 Dec 2010 09:16:45 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id b26sm696773vby.3.2010.12.03.09.16.41
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 09:16:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101203170800.GE12910@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162815>

Jonathan Nieder wrote:
> Giuseppe Bilotta wrote:

>> --- a/git-web--browse.sh
>> +++ b/git-web--browse.sh
>> @@ -138,6 +138,51 @@ then
>[...]
>> +if test -z "$browser" -a -n "$BROWSER"; then
>> +	OLDIFS="$IFS"
>> +	IFS=:
>[...]
>> +	IFS="$OLDIFS"
>
> Micronit: on some shells (e.g., old ash[1]), IFS starts out unset if
> it hasn't been inherited in the environment.

Of course, we are using this idiom in a few places already, so that
can be saved for another topic.  Sorry for not checking sooner.
