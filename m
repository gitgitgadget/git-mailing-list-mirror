From: David Borowitz <dborowitz@google.com>
Subject: Re: Make git-push silent
Date: Thu, 21 Oct 2010 11:49:15 -0700
Message-ID: <AANLkTik3GndR27OH-dtmQ7w4dbnACymxunvZ3=PNbQxT@mail.gmail.com>
References: <20101021181906.GA28700@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 20:49:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P90Cu-0002XR-4x
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 20:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757332Ab0JUStj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 14:49:39 -0400
Received: from smtp-out.google.com ([216.239.44.51]:7577 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335Ab0JUSti convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 14:49:38 -0400
Received: from wpaz5.hot.corp.google.com (wpaz5.hot.corp.google.com [172.24.198.69])
	by smtp-out.google.com with ESMTP id o9LIncXT025072
	for <git@vger.kernel.org>; Thu, 21 Oct 2010 11:49:38 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1287686978; bh=6YeBakxVODLwHHMBtsgfHfbGYXM=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Content-Type:Content-Transfer-Encoding;
	b=FSuEKJeZ2tzfGoISkqVo9Z2AmVCbsvSVI5QvXSAy+wf86KugMq1K5gxce/BmFHFHC
	 gR3G4Z9vq7Fpgs6xEl85g==
Received: from pwi8 (pwi8.prod.google.com [10.241.219.8])
	by wpaz5.hot.corp.google.com with ESMTP id o9LImedS028989
	for <git@vger.kernel.org>; Thu, 21 Oct 2010 11:49:37 -0700
Received: by pwi8 with SMTP id 8so180701pwi.18
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 11:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=nHy2+HArcMfKXeRfGaDqzGRN6u3uh9x5CDwtYICwKbg=;
        b=PIu3LSTFRIkLmw7Mn/aMclRmIQnICkmGs0wsTmmdO8ItQ7ZRI0trayKMkgDPBrz0y9
         /+AoP5b7yJik4HAhRIiA==
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=PRBT9EBuFxDvVm+pkXX2T5y/4xOWlQRVC+GMiJrtcGqDsyPc7UNrKw0AZbEjlsdQSo
         2AA9YrLkgC5Q0S/DfGtw==
Received: by 10.142.125.4 with SMTP id x4mr1146756wfc.234.1287686976368; Thu,
 21 Oct 2010 11:49:36 -0700 (PDT)
Received: by 10.229.223.140 with HTTP; Thu, 21 Oct 2010 11:49:15 -0700 (PDT)
In-Reply-To: <20101021181906.GA28700@nibiru.local>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159536>

On Thu, Oct 21, 2010 at 11:19, Enrico Weigelt <weigelt@metux.de> wrote:
>
> Hi folks,
>
>
> is there a way to make git-push silent in a way that it only
> outputs something in case of error ?
>
> I'm using it as a backup tool via cron scripts, and therefore I
> dont want any output when everything went okay.

Not a solution on the git front, but I use cronic[1] to do this with
arbitrary cron scripts (including some that do git pull/fetch). It
traps all script output and is silent unless it encounters a nonzero
return code.
[1]=A0http://habilis.net/cronic/

>
> If there's no such a feature/switch yet, could anyone give me
> a hint where/how to implement this ?
>
>
> thx
> --
> ---------------------------------------------------------------------=
-
> =A0Enrico Weigelt, metux IT service -- http://www.metux.de/
>
> =A0phone: =A0+49 36207 519931 =A0email: weigelt@metux.de
> =A0mobile: +49 151 27565287 =A0icq: =A0 210169427 =A0 =A0 =A0 =A0 sky=
pe: nekrad666
> ---------------------------------------------------------------------=
-
> =A0Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
> ---------------------------------------------------------------------=
-
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
