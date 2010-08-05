From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [GSoC update extra!] git-remote-svn: Week 13
Date: Thu, 5 Aug 2010 17:23:29 -0500
Message-ID: <AANLkTikaVq8kmOtxcMmfkmmNAMtWJ5h2OuMNb+jR589-@mail.gmail.com>
References: <20100730190124.GA2995@kytes> <0C6B8C5E-15BA-43AD-B2F2-914F39EA6046@cordelta.com> 
	<AANLkTi==fm8kxoB9aPYJNqBO=O9ALq-1qTzQj9RSXYBN@mail.gmail.com> 
	<70D9930D-DDB6-493D-9936-21E9CD4426A2@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: David Michael Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 00:47:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh9DP-0000UD-Ma
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 00:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760803Ab0HEWXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 18:23:54 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40521 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760792Ab0HEWXt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 18:23:49 -0400
Received: by ywh1 with SMTP id 1so2648464ywh.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 15:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=/0QdVjW7WUIW6OOF3wd4FlKqjXXFusLnOeRDLnw8A9Y=;
        b=gHcfREoH7xWdGocKS8vTEi9JU8Vwg6N2S9EMcMf5rJRjJMZtgyBVGhssHQgz/2PM7Z
         JsEdGJNdkD3VhhFexw+vWBovKEd6/jjU84CmdkmZmJF6NIgcsIdH5pQnargy4zYOAvYr
         /PdQ6Shh9oMtwgS+fUWTU4zWbjfySDO0KG2Pk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=RUn8guTgDh0AuAvQejiBAcp9hqmu0PoHNkQYk7ZPBDIbMdp5o2+BmhqSFqoMhFgzV6
         QnRNrcqQm8Mw/N0W2iYqgm3sFWXFXKHoF4NYt8mKE+UTprXQL9jwY8yXcbj9SIfvxQiS
         w1O3fkrbvthQHMy+PJjuICOmFnlbbnyfIFmLA=
Received: by 10.150.95.4 with SMTP id s4mr3270524ybb.129.1281047029182; Thu, 
	05 Aug 2010 15:23:49 -0700 (PDT)
Received: by 10.150.93.6 with HTTP; Thu, 5 Aug 2010 15:23:29 -0700 (PDT)
In-Reply-To: <70D9930D-DDB6-493D-9936-21E9CD4426A2@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152736>

Heya,

On Thu, Aug 5, 2010 at 17:15, David Michael Barr
<david.barr@cordelta.com> wrote:
> The primary issue is a blob may be repeated in a non-copy operation,
> requiring its content to be described again. This sort of operation only
> happens 20% of the time with the ASF repository. We would have to
> either write out the content again or compute a new delta depending
> on the target version of the svn dump stream.

Ah, you mean that there might be a "'M' SP <mode> SP <dataref> SP
<path> LF" line in a non-copy operation. It should probably be not
that hard to teach git fast-export to not do that.

-- 
Cheers,

Sverre Rabbelier
