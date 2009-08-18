From: skillzero@gmail.com
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Mon, 17 Aug 2009 17:34:06 -0700
Message-ID: <2729632a0908171734p16d6ee7dm5f62848f7625ffbc@mail.gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
	 <2729632a0908171602m3c05c97bx9ce31e8960df9198@mail.gmail.com>
	 <alpine.DEB.1.00.0908180111340.8306@pacific.mpi-cbg.de>
	 <200908180217.35963.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 02:34:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdCeW-0004qd-9j
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 02:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbZHRAeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 20:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbZHRAeG
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 20:34:06 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:60896 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbZHRAeF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 20:34:05 -0400
Received: by qyk34 with SMTP id 34so2469508qyk.33
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 17:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=m/yyzQh2IS2OpsTkICyHdvNdFVL/g4nvBMEmkXflgfE=;
        b=QDdQPxGwdlucZ1Q6SLd3uZ65Rno7CXgX9SA8vtLKROeH0GKcvIY1x8AZqYkanKr0N3
         twYb+qBT0HWGQxr4xJEKWoU72D/j9qoVTsNHbC0Z5ZP66jZy6CrFvW8i0DwG3QP2fYUn
         lsYlD4O3mowfT93xy/S5KMLvvFw0c92WVS+IQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=b4X6IFwVhXZ0Kp4xAA3ROlrsWGBynl1K76bzgXB24yTjhjlhDs1TJ5zxbb94nRBsk5
         7LGIXG/X7J0AjM46N2UnG2aOfKe6LMpftP887SZfXIaK/BTBcbzmlPDrPePje+HoZdV/
         pHpE9b8ekSBP1u64hcFooJiIxOGYOoUX6Dlc8=
Received: by 10.224.50.137 with SMTP id z9mr4898702qaf.83.1250555646348; Mon, 
	17 Aug 2009 17:34:06 -0700 (PDT)
In-Reply-To: <200908180217.35963.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126329>

On Mon, Aug 17, 2009 at 5:17 PM, Jakub Narebski<jnareb@gmail.com> wrote:

> There is e.g. question if "git grep" should search "no-checkout" files;
> in the "assume-unchanged" case it should, I think, search index version.

I would like it to git grep to not search paths outside the sparse
area (although --no-sparse would be nice for git grep in case you did
want to search everything). The main reason I want sparse checkouts is
for performance reasons. For example, git grep can take 10 minutes on
my full repository so excluding paths outside the sparse area would
reduce that to a few seconds.
