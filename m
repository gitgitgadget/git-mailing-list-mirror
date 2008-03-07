From: Pekka Kaitaniemi <kaitanie@cc.helsinki.fi>
Subject: Re: [PATCH v2] gitk: Add horizontal scrollbar to the diff view
Date: Fri, 7 Mar 2008 14:16:19 +0200
Message-ID: <20080307121619.GA1768@localdomain>
References: <20080306123845.GA12115@localdomain> <18384.30851.318641.612252@cargo.ozlabs.ibm.com>
Reply-To: kaitanie@cc.helsinki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kaitanie@cc.helsinki.fi, gitster@pobox.com, newsletter@dirk.my1.cc,
	git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 13:17:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXbVm-0005lr-Su
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 13:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757076AbYCGMQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 07:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756954AbYCGMQk
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 07:16:40 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:5346 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758645AbYCGMQi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 07:16:38 -0500
Received: by nf-out-0910.google.com with SMTP id g13so245465nfb.21
        for <git@vger.kernel.org>; Fri, 07 Mar 2008 04:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:reply-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=qGhZZNyG6fxDOU/4h/JNh4JNLwxCMUNdLouxrS/RQm0=;
        b=lYleUr4VFNxt+6CPevrWSAtj9XobqZL11JGG6xzb3ogFgekWg6ASkX5/7gR2kfPpeDCtLN6+u8Ue/aFzWRMpoWDeBRhc5q26EZMgQCmXAHKcOOr3UqmichUMbCQzxywTUaErnGX4+aPNpEnb2e8n28xexFqyN8YWZnpG4MxeGRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=ZR2igMhuzR+koIctI+NNHot+xhRQQy1T7N1oLmLg3dwuwrUy4ejFKss4KzKEAs+FHWU8ol1KBjnoYQLLlrMylsBNyswAM+HlgHPAjTwPaiPoyiA0ZINdMCRd/yAytiAhD4ZaAow6lDORHb2dQ182VHpb1dGPZ+aGCNgTdh5R90A=
Received: by 10.78.195.10 with SMTP id s10mr3575812huf.10.1204892196747;
        Fri, 07 Mar 2008 04:16:36 -0800 (PST)
Received: from shadow ( [128.214.182.232])
        by mx.google.com with ESMTPS id z28sm2098809hub.37.2008.03.07.04.16.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Mar 2008 04:16:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <18384.30851.318641.612252@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76483>

On Fri, Mar 07, 2008 at 10:04:35AM +1100, Paul Mackerras wrote:
> Pekka Kaitaniemi writes:
> 
> > -	-yscrollcommand scrolltext -wrap none
> > +	-yscrollcommand scrolltext  -wrap none \
> 
> Why this whitespace change?

For no good reason at all... Fixed. The real change was the \ at the
end of the line.

> > +    scrollbar .bleft.sbhorizontal -command "$ctext xview" -orient h \
> > +	-width 10
> 
> Are you using Tk 8.4 or 8.5?  With Tk 8.5 the scrollbars are thinner
> and I wonder whether specifying a width of 10 will actually make it
> fatter than it would be otherwise.

I was using Tk 8.4 to make the patch. Today I installed 8.5. On 8.5 it
seems that the horizontal scroll bar is as wide as the default one, or
maybe slightly narrower so it looks quite OK. At least it behaves this
way on Linux. I can't really test how well it works on Mac and Windows
since I don't use them.

So Tk 8.5 actually has more reasonably sized scrollbars than
8.4. Maybe the hardcoded width setting should be dropped? This would
probably make the patch more "cross plattform" because Windows and Mac
versions of Tk may have different "themes" and scrollbar widths than
the Linux version. On those plattforms the width of 10 might be fatter
than the default.

Pekka
