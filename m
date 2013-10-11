From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/5] pull: rename pull.rename to pull.mode
Date: Fri, 11 Oct 2013 18:56:23 -0500
Message-ID: <52589027a4851_5dc4c2be742754f@nysa.mail>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
 <1378689796-19305-2-git-send-email-felipe.contreras@gmail.com>
 <522E3C6A.3070409@bbn.com>
 <CAMP44s1OyST3S1HEdS38WPsjq6w9SekuwT4DRUgVvduATox9tw@mail.gmail.com>
 <20130910022152.GA17154@sigill.intra.peff.net>
 <CAMP44s1FfQ-1pAK8T1cmiZk4i17HnpvzPwuZrzHiiXSmGzbrRw@mail.gmail.com>
 <vpqmwnljdmn.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>,
	Philip Oakley <philipoakley@iee.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 12 02:03:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUmg0-0001yw-2r
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 02:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579Ab3JLADU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 20:03:20 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:42982 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056Ab3JLADT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 20:03:19 -0400
Received: by mail-oa0-f41.google.com with SMTP id n10so2978597oag.28
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 17:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=QYo/MZOECgt0vRac8s2TAczY2E/QT9YoBMtZnqmZWAk=;
        b=AXP9JMSC/c/b4tfBI/h1urQmvg443nmlXJib3NPbGzxRbre721mTraQpZN1aUC30HD
         IERrsVXcFoqYO2YsiWiNvUqVPoBI2Ci4nu6UMlEB/qPZKdaqI4PQiUmBT73aTu+ML1bE
         Ts0iHRU+4ZONNPUz7vc/jOLcBvfE5bXVTWv4e9itasT6TCRyTgG8Erzzp3az+fLA/Fvi
         iS2Wd+6nfhFd1eQiF/NKtLcWIcowcRSwdnLqMSzACnf9VfWfJwZlRTBsk8D8CnR4IO+N
         jTlZnKKkAyfWkfVRbQ1lyCmel3T+9I0gV5dEax5CX+1sovePENSFkNpDDereLF5Xd72d
         EQJA==
X-Received: by 10.182.230.135 with SMTP id sy7mr16226112obc.24.1381536199285;
        Fri, 11 Oct 2013 17:03:19 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xr8sm26868842obc.12.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Oct 2013 17:03:18 -0700 (PDT)
In-Reply-To: <vpqmwnljdmn.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235929>

Matthieu Moy wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > On Mon, Sep 9, 2013 at 9:21 PM, Jeff King <peff@peff.net> wrote:
> >> On Mon, Sep 09, 2013 at 05:49:36PM -0500, Felipe Contreras wrote:
> >>
> >>> > These deprecation warning messages should be written to stderr, and
> >>> > should probably be prefixed with "WARNING: ".
> >>>
> >>> Is there any deprecation warning that works this way?
> >>
> >> The ones in C code typically use warning(), which will prefix with
> >> "warning:" and write to stderr. They do not use all-caps, though.
> >>
> >> Try "git log --grep=deprecate -Swarning" for some examples.
> >
> > I'm asking about the ones in shell, because this is a shell script.
> 
> No user cares whether "git pull" is written in shell. shell Vs C is an
> implementation detail, stdout Vs stderr is user-visible.

You are free to go ahead and implement 'warning ()' in git-sh-setup.sh, in the
meantime no shell script does that, and that's no reason to reject this patch
series.

-- 
Felipe Contreras
