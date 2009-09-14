From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 2/2] remove NORETURN from function pointers
Date: Mon, 14 Sep 2009 15:26:52 +0200
Message-ID: <40aa078e0909140626k63b9de2fu8c9411baf8200da6@mail.gmail.com>
References: <1252923370-5768-1-git-send-email-kusmabite@gmail.com>
	 <1252923370-5768-2-git-send-email-kusmabite@gmail.com>
	 <20090914105750.GB9216@sigill.intra.peff.net>
	 <40aa078e0909140440x2e189957uf66f36ff29bef302@mail.gmail.com>
	 <20090914120311.GA17172@sigill.intra.peff.net>
	 <40aa078e0909140532q693a7f9qc3d9b1d354cac356@mail.gmail.com>
	 <4AAE4087.5030607@viscovery.net>
	 <40aa078e0909140612w71ad3bdeyfa94838cb57cec19@mail.gmail.com>
	 <4AAE42F2.30304@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 15:27:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBa7-0000qe-DW
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 15:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330AbZINN0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 09:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755231AbZINN0v
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 09:26:51 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:64210 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755126AbZINN0u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 09:26:50 -0400
Received: by fxm17 with SMTP id 17so828602fxm.37
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 06:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=iaYb8vpqkn8kbb7XPvvjfK7NTLcfgaAo4NclndG9sqU=;
        b=HpEOU6AXyjmFhqL2W4tCzBSGgvlRHJeSp5xnCBw7kwZS5i3SLHtRH9QBfgMTWYfZb6
         g3uETCGKA1wya1/OI4ZOwoc34A81ilUQCuzsNfsWB3VRiReXr2Shu2WGbpkpEJkEy2M0
         DZ1v3gjPMfcmsCavbBV5xmaoR9EVAehlL17oo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=aRzn3ZBEiwke2OnMMeizkQQBW06P8SldweOhB2FVCywJtJIC+Nvn91C3jj0uWee0F5
         E9jSiXUDfKPnHcy9rZv/+y5VD4Do2u/V7cX3NYzilc9+gcEvMmcfRBt5K6tvQcHpO0wa
         VlK1Al5MG9dka92S8UtaUgS3/LqG1LENA9yyo=
Received: by 10.204.136.220 with SMTP id s28mr5113493bkt.207.1252934812603; 
	Mon, 14 Sep 2009 06:26:52 -0700 (PDT)
In-Reply-To: <4AAE42F2.30304@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128478>

On Mon, Sep 14, 2009 at 3:19 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> "The" warning? Not "the two" warnings? Then I suggest to stop here; MSVC
> is only half-competent with regards to noreturn.

There was only one warning in this regard on MSVC - the one about
unreachable code. And yes, MSVC is only half-competent, but it seems
it's competence is in the half that matters in our case.

Do you suggest to stop the patch-series, or to stop the testing? I'd
prefer having NORETURN for die() etc in MSVC-builds, as it allows the
compiler to generate better code. I'm prefectly fine about not having
NORETURN for the function pointers. GCC should be competent enough to
catch (very theoretical) errors, and we get the nice speed-improvement
on MSVC. I don't see the down-side.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
