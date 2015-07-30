From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull --upload-pack reversion in git 2.5.0
Date: Thu, 30 Jul 2015 11:41:31 -0700
Message-ID: <CAPc5daXPY7RQSM6oyFYJ2LjYjaT9dDG-+3=nbHONirGh50pdBA@mail.gmail.com>
References: <20150730154523.GA17002@kitenet.net> <vpqvbd1k1ke.fsf@anie.imag.fr>
 <20150730183144.GA6360@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Paul Tan <pyokagan@gmail.com>
To: Joey Hess <id@joeyh.name>
X-From: git-owner@vger.kernel.org Thu Jul 30 20:41:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKsmC-0000KR-GU
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 20:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbbG3Slw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 14:41:52 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36525 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbbG3Slv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 14:41:51 -0400
Received: by iocc131 with SMTP id c131so4652243ioc.3
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 11:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=HjoUQbgrPhzJLu9QF/fZKqBLAxNKF+49oyGUboveUVo=;
        b=gOvllNCrxikxHJ3/dUHPIwIf7rLd0ZFE0YqSSiwM97g8j2PGs8oGXeXO4WVsIOZofL
         /UgC0DeQqsDZ66mSWOcBM24rNUgMyUb++AzoANwvt8NaP/vVZ7LbSQRlFLXkNdJ+gFV2
         1UKyd6wpUcKDupY31xSVSkEtqOCdSHO6JJ3xbQWrbskn6FVgiSv+uP/i6xMxZYSrboIR
         BtvcbqmfDCqES14SWyXO87cl4EMx406tC7T/PZYwsMnOf/MtPWkZAJI5rxpLtiXZT8Ag
         Xtm+lI5DztShSC/YX39StJwsv8Bsm9XkYvqm8SheimY2dcKTc4r26o0f9JTatcUylCB6
         MU6A==
X-Received: by 10.107.12.30 with SMTP id w30mr14462777ioi.82.1438281711188;
 Thu, 30 Jul 2015 11:41:51 -0700 (PDT)
Received: by 10.36.41.149 with HTTP; Thu, 30 Jul 2015 11:41:31 -0700 (PDT)
In-Reply-To: <20150730183144.GA6360@kitenet.net>
X-Google-Sender-Auth: FbqaUQIrX2yPmrHpzCqNcuboMvU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275025>

On Thu, Jul 30, 2015 at 11:31 AM, Joey Hess <id@joeyh.name> wrote:
> I think this comes down to a lack of quoting where git-pull runs
> git-fetch. Before eb2a8d9ed3fca2ba2f617b704992d483605f3bb6,
> "$@" was passed through to git-fetch, but now there is a $upload_pack
> which is passed without being quoted.

Yes, it is not just the matter of using "$upload_pack", though ;-)

${upload_pack+"$upload_pack"} or something.
