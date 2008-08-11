From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: git-bisect: weird usage of read(1)
Date: Mon, 11 Aug 2008 16:18:40 +0200
Message-ID: <38b2ab8a0808110718x2f63608ga3d2d77e317ce4eb@mail.gmail.com>
References: <38b2ab8a0808110657y24ac9526wca4acea3bddaec00@mail.gmail.com>
	 <alpine.DEB.1.00.0808111615260.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 11 16:19:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSYFN-0003xh-7T
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 16:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbYHKOSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 10:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbYHKOSm
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 10:18:42 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:3468 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbYHKOSl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 10:18:41 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1388886wri.5
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 07:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=G9TAVLQg0tdNqfRMpVeoV9B9nQnbqUTjbfYMm/YNv4o=;
        b=HY+7UQzRUNt1rTyfyPEGvhQKklTv5oR5FXVMPpmi418H4qY+5rmubkOKsHAiH5vTQ3
         g949J0rjr60lJFgE6o+2qzav/nzl3j56EVYN4pcfn7baeBGXQIKFPIU3BTnMCkytsAy0
         H1e+M+dB7RRqSY/wnShr+ZCoTlHx40dB6iOAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nQXhHI0TYei0rC4t+Kbf6i3Y9vMtShBAXLB1bZAI0j+l3CTJtSZPjkCy6N8DJZGErc
         +YEzmr/JYWcwMqNe9eWxDxImgDqr5H5ugbnpTCH3ySjkx0UzHHFDVNjQ58Syy0wZ96RT
         /ltSVxO+2Uu4589onv0S7UkbgylE02nPxz4sY=
Received: by 10.90.33.5 with SMTP id g5mr10635660agg.113.1218464320245;
        Mon, 11 Aug 2008 07:18:40 -0700 (PDT)
Received: by 10.90.98.3 with HTTP; Mon, 11 Aug 2008 07:18:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0808111615260.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91939>

Hello

On Mon, Aug 11, 2008 at 4:15 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 11 Aug 2008, Francis Moreau wrote:
>
>> I found this in git bisect:
>>
>>               printf >&2 'Are you sure [Y/n]? '
>>               case "$(read yesno)" in [Nn]*) exit 1 ;; esac
>>
>> which looks very weird since read(1) returns a status and not the
>> string reads from std input.
>>

sorry I should have said that there's a status but no output...

>> Am I missing something ?
>
> Yes.  "$()" does not return the status, but the output.
>

But what's the output in that case ?

-- 
Francis
