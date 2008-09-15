From: "Tor Arvid Lund" <torarvid@gmail.com>
Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
Date: Mon, 15 Sep 2008 13:02:32 +0200
Message-ID: <1a6be5fa0809150402m6020698ci9204109a0b615c1c@mail.gmail.com>
References: <16219.81556.qm@web95005.mail.in2.yahoo.com>
	 <20080915063521.GA1533@linode.davidb.org>
	 <7vy71tetvt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "David Brown" <git@davidb.org>, dhruva <dhruva@ymail.com>,
	"GIT SCM" <git@vger.kernel.org>, "Simon Hausmann" <simon@lst.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 13:04:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfBsW-0007kT-Fn
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 13:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbYIOLCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 07:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbYIOLCf
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 07:02:35 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:51703 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbYIOLCe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 07:02:34 -0400
Received: by an-out-0708.google.com with SMTP id d40so197914and.103
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 04:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=x3DQx+3afGG1mwtGC7dlTHtXlTyNzYVstBcusMGyY3I=;
        b=vaA4diCGJ/+sqB4jFFEOcHaa893edtZUpvhAJMhm5Cf8358w1GC4sQ50bVhTZVGLlb
         LLKrQp4Wzxr22EA1Rfyyz/nBQpuh1CbNr/Egf9u2XX5wnCuAGhuorwx0pZD9hqJTGRmT
         LEh4PKjAl3RYrtIUyeHcw1xNlYgC3JU9OjWhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=b4r7cpJVz1BT4ej0++TVkkIhLod9ywtlt35J5Fr4CFbpfqtCj3iVOamxyXprQ3dJME
         uNwMUS8OlQ9i+jAuNF46Ib16sRx7A5i6638N2hJZKRNSV/2M+1PuHPcj4Y8/rjFv6b/z
         p6WhB9SdGKMjhUvy3a4PsmxJJUbZcvS05xY2g=
Received: by 10.86.79.19 with SMTP id c19mr5797871fgb.79.1221476552806;
        Mon, 15 Sep 2008 04:02:32 -0700 (PDT)
Received: by 10.86.79.9 with HTTP; Mon, 15 Sep 2008 04:02:32 -0700 (PDT)
In-Reply-To: <7vy71tetvt.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95898>

On Mon, Sep 15, 2008 at 9:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> David Brown <git@davidb.org> writes:
>
>> ...  As far as I can tell, P4 completely
>> ignores whatever the $Id: ...$ headers happen to be expanded to at the
>> time of checking.  You can put garbage there, and it check in fine.
>> ...
>> I guess it isn't a problem to make this optional in git-p4, but I
>> don't think this patch is solving the right problem.
>
> Hmm.  I do not do p4, but what I am guessing is that there probably is a
> configuration switch on the p4 side that lets you check in files with
> "$Id: garbage $" in them, while dhruva hasn't turned that switch on.

Hmm.. I thought this was not a p4 problem. I think however, that
"git-p4 submit" tries to do git format-patch and then git apply that
patch to the p4 directory. In other words, I believe that git apply
fails since the file in the p4 dir has the keywords expanded, while
the patch does not. I haven't done any careful investigation, but If
my assumption is true, it sounds like dhruvas patch should work...

-Tor Arvid Lund-
