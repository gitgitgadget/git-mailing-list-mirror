From: "J.C. Pizarro" <jcpiza@gmail.com>
Subject: Re: Question about your git habits
Date: Sat, 23 Feb 2008 19:47:13 +0100
Message-ID: <998d0e4a0802231047t1338439cj1a1c98f046e6ebaf@mail.gmail.com>
References: <7vfxvk4f07.fsf@gitster.siamese.dyndns.org>
	 <998d0e4a0802221823h3ba53097gf64fcc2ea826302b@mail.gmail.com>
	 <998d0e4a0802221847m431aa136xa217333b0517b962@mail.gmail.com>
	 <20080223113952.GA4936@hashpling.org>
	 <998d0e4a0802230508w12f236baiaf2d9ab5f364670a@mail.gmail.com>
	 <20080223131749.GA5811@hashpling.org>
	 <998d0e4a0802230536w74e93ec3s40c77d52b183a419@mail.gmail.com>
	 <20080223140153.GB5811@hashpling.org>
	 <998d0e4a0802230910o1cd087f1y6b2398cfde4cfe08@mail.gmail.com>
	 <20080223181631.GA9405@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Charles Bailey" <charles@hashpling.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 19:48:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSzPz-00066o-Ae
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 19:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760075AbYBWSrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 13:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758062AbYBWSrQ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 13:47:16 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:16778 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980AbYBWSrP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 13:47:15 -0500
Received: by ti-out-0910.google.com with SMTP id 28so545443tif.23
        for <git@vger.kernel.org>; Sat, 23 Feb 2008 10:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=VKXxFOV0cE3dAUOCjJ+JqcnHQVb0bM0HMd7/I9Wjoqw=;
        b=o+EPIn3zuWeeCLiLCssHSb2CfQY3PLvYgyQRzbnrl6R0kdSbGT6e7fnwGY8dF3caR/jMda71zTMFz020ISyGqkNNEQX9MpEdIJmbuCrtz0Ie61LVtuS522ueN7R4KuecQ789jAIZJHJofHZAW43cREA3DJwzoEapy60GBQ0yxfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KRwNEVbXzU6dxWu9lB5geJdU2sn4U87HxfxCCpKnkkj7TgwZLIK6u+I5s/N6l6KobMoZqT0qz2RQM3p4IDRxmKd4vsM1FfeJnr+hryNKcGRjka7eqFPEDsjhqDsFbCRC7vLe2v4uVVYdQ8l206cc1lLWwx4yRs1nL0YgZGU91pY=
Received: by 10.110.32.9 with SMTP id f9mr515184tif.30.1203792433535;
        Sat, 23 Feb 2008 10:47:13 -0800 (PST)
Received: by 10.70.40.12 with HTTP; Sat, 23 Feb 2008 10:47:13 -0800 (PST)
In-Reply-To: <20080223181631.GA9405@hashpling.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74838>

On 2008/2/23, Charles Bailey <charles@hashpling.org> wrote:
> You're confusing two things together here. Conceptually, the git
>  database is a database of immutable objects. How it is stored is a
>  lower level implementation detail (albeit a very important one in
>  practice). The delta chains in the pack files are nothing to do with
>  git objects.

In Documentation/git-repack.txt says:

git-repack is used to combine all objects that do not currently
reside in a "pack", into a pack. It can also be used to re-organize
existing packs into a single, more efficient pack.

A pack is a collection of objects, individually compressed, with
delta compression applied, stored in a single file, with an
associated index file.

### Can you explain me that delta chains in the pack files are
 nothing to do with git objects? ###

Packs are used to reduce the load on mirror systems, backup engines,
disk storage, etc.

> You seem to be comparing something that I've said with something that
>  you said. Originally I thought that you were making a bandwidth
>  argument, now you seem to be making a repacking time argument. Is X
>  supposed to represent to second cloned repository?

Yes, X is as the 2nd cloned repository but highly repacked, same size is not.

>
>  If you git clone with --reference or git fetch from a non-dumb source
>  repository then the remote end will generate a packfile of just the
>  objects that you need to update the local repository. If the remote
>  side is fully packed then A can reuse the delta information it already
>  has to generate this pack efficiently. On the local side, there is no
>  need to unpack these objects at all. The pack can just be placed in
>  the repository and used as as.

Is not it redundant to place git objects and pack files in the same repo?
1. Or erase the unnecesary pack files because there are git objects.
2. Or erase some git objects because there are delta chains in pack files
     that can generate the same git objects erased previously.

> What do you mean by 'the eternal repacking 24/365'? What is it trying
>  to achieve?

It's an uninterrumpted computing that is generating a sequence of
spanning trees in convergence to smaller packs.
   Each smaller spanning tree is found, the pack file is updated.

> What is the weekly user? Why would the 'binary delta' be better than
>  an incremental pack in this case?

Because the user wants to clone weekly 240 MiB in 1st week, 220 MiB in
2nd week, 205 MiB in 3rd week, .... 100 MiB repo! in Nth week instead of
240+1+1+1+1 MiB of incremental packs.

What is better for the user in the Nth week, 100 MiB repo or 244 MiB repo?

   ;)
