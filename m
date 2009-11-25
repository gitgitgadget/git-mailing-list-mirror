From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: What is the best way to synchronize two *bare* repositories with 
	each other?
Date: Wed, 25 Nov 2009 11:14:20 +0100
Message-ID: <81b0412b0911250214nb97f997h686a10622fbf3e01@mail.gmail.com>
References: <7FF082147E322048955113B6CB87A7C0081731C659@MCHP058A.global-ad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Liebich, Wolfgang" <wolfgang.liebich@siemens-enterprise.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 11:14:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDEtV-0002Ou-FY
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 11:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758612AbZKYKOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 05:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758602AbZKYKOR
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 05:14:17 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:57395 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758599AbZKYKOP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 05:14:15 -0500
Received: by bwz27 with SMTP id 27so6751137bwz.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 02:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=o4Xlh6xUVRHLsA16VNuW1SbSR7fF42XmMb6UzPDnVrA=;
        b=XBvECUk4KvI8bW85RG6CBk0m9Y4sf1SDcsQ2WsbDhxp2vJx0Y1ubzduAwP4OxtRkEu
         lkJltTjVMJZYjQHxCcU7+Ls8byURtSJiPD5HF/2A393nOTCVbLcDDTNokwXGHX6GfoFa
         HOEWLUfi7rSVxO7q8O4I3Mk8akJjdToC4vQvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=S3rYB5D93cnhxY0RQ8BZPWrQp4gG3Bv9jyf4QbAPSf/skqFUVdzwT/Ql2pBmSuEUM2
         YGGn3SN9Ckd77ITgb4qq6IhwM7D2jexewEDPH0bNNESyErPD3OZatLOCEQ39Q0/bOGS/
         Fo6GRzdQevQwpEqqZNxCUOfLL7y5AscjexBaw=
Received: by 10.204.32.204 with SMTP id e12mr2735684bkd.51.1259144060764; Wed, 
	25 Nov 2009 02:14:20 -0800 (PST)
In-Reply-To: <7FF082147E322048955113B6CB87A7C0081731C659@MCHP058A.global-ad.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133623>

On Tue, Nov 24, 2009 at 22:19, Liebich, Wolfgang
<wolfgang.liebich@siemens-enterprise.com> wrote:
> Hi,
> Let's say I have two bare git repositories, bareA and bareB.
> I also have a third non-bare repo, lets call it workA. Coworkers also have their working repositories, they all
> synchronize back to repoA.
> My work repo can only synchronize directly with repoB.
> What is the best way to keep repoA and repoB synchronized to each other?

Take a look at "--mirror" option of "git clone" (it sets up a remote
with references
mapping like this: refs/*:refs/*).
