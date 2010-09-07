From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation: move RelNotes into a directory of their
 own
Date: Mon, 6 Sep 2010 21:01:09 -0500
Message-ID: <20100907020109.GI1182@burratino>
References: <alpine.LFD.2.00.1009062026330.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Sep 07 04:03:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsnWn-0003Du-73
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 04:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933Ab0IGCDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 22:03:11 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:40013 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755855Ab0IGCDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 22:03:09 -0400
Received: by qyk33 with SMTP id 33so4847320qyk.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 19:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=j5OYH8zx7pj45AKLuZ87Es8BZ776hrHl54zJMj+XCPM=;
        b=odAcCyAqH88Bd6+WQDTZzwOJZxsAi/30bEfjeSUAufTPXo4jUxzdkgRt0kuQBRUswJ
         8g0wgXWuVBMkVm1qaYq1FmyBYDhbtOateOrYxzmIstULwswLvp1m7fkFl0teIiMax6EH
         H9M1mbG1oyNifLR/f3AX+8KChIOOu+gVQxR+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XX5GQtDBK/OmIqMggyO7Mwbu3erRwn7c4DH6xx8YTKeRaeJJ3JY8xJzAXlUrHvl8rk
         l+jMfvi3nXQte46TN9HmeEFDM6APXuxatc4ACORv4waFj5OW5kAq7Y8jJtvaYTkbISTt
         cgyyYBJbIMkgLnUKwXldmnalGjeKSsOQSBVbE=
Received: by 10.229.189.83 with SMTP id dd19mr4139996qcb.92.1283824987511;
        Mon, 06 Sep 2010 19:03:07 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r1sm6432544qcq.46.2010.09.06.19.03.06
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 19:03:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1009062026330.19366@xanadu.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155666>

Nicolas Pitre wrote:

> There are 108 of them already.  That's a bit more than one third of
> all the files in the Documentation directory already, and still growing.
> 
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> ---
>  .../{RelNotes-1.5.0.1.txt => RelNotes/1.5.0.1.txt} |    0
>  .../{RelNotes-1.5.0.2.txt => RelNotes/1.5.0.2.txt} |    0
[...]

Junio: Because of

	for th in \
		"$T"/*.html "$T"/*.txt \
		"$T"/howto/*.txt "$T"/howto/*.html \
		"$T"/technical/*.txt "$T"/technical/*.html
	do
		h=`expr "$th" : "$strip_leading"'\(.*\)'`
		case "$h" in
		index.html) continue ;;
		esac
		test -f "$h" && continue
		echo >&2 "# rm -f $th"
		rm -f "$th"
	done

this would invalidate old URLs like

	http://www.kernel.org/pub/software/scm/git/docs/RelNotes-1.7.2.3.txt

, no?  Is there some easy way to set up the appropriate HTTP 301
responses?

Aside from that, this looks like a very good idea.
