From: Martin Fick <mfick@codeaurora.org>
Subject: Re: [RFC PATCH] repack: rewrite the shell script in C.
Date: Wed, 14 Aug 2013 17:28:29 -0600
Organization: CAF
Message-ID: <201308141728.29971.mfick@codeaurora.org>
References: <520BAF9F.70105@googlemail.com> <201308141628.42163.mfick@codeaurora.org> <7vd2pfsx3j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, iveqy@iveqy.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 01:28:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9kUV-00031b-MQ
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 01:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760170Ab3HNX2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 19:28:32 -0400
Received: from smtp.codeaurora.org ([198.145.11.231]:57046 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758100Ab3HNX2b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 19:28:31 -0400
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id 21A4D13EF2F;
	Wed, 14 Aug 2013 23:28:31 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id 1359B13EF89; Wed, 14 Aug 2013 23:28:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from mfick-lnx.localnet (mfick-lnx.qualcomm.com [129.46.10.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id CAE0A13EF2F;
	Wed, 14 Aug 2013 23:28:30 +0000 (UTC)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <7vd2pfsx3j.fsf@alter.siamese.dyndns.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232323>

On Wednesday, August 14, 2013 04:53:36 pm Junio C Hamano 
wrote:
> Martin Fick <mfick@codeaurora.org> writes:
> > One suggestion would be to change the repack code to
> > create pack filenames based on the sha1 of the
> > contents of the pack file instead of on the sha1 of
> > the objects in the packfile. ...
> > I am not 100% sure if the change in naming convention I
> > propose wouldn't cause any problems?  But if others
> > agree it is a good idea, perhaps it is something a
> > beginner could do?
> 
> I would not be surprised if that change breaks some other
> people's reimplementation.  I know we do not validate
> the pack name with the hash of the contents in the
> current code, but at the same time I do remember that
> was one of the planned things to be done while I and
> Linus were working on the original pack design, which
> was the last task we did together before he retired from
> the maintainership of this project.

Perhaps a config option?  One that becomes standard for git 
2.0?

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
 
