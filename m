From: David Kilzer <ddkilzer@kilzer.net>
Subject: Re: [PATCH] rebase -i -p: use rerere to resolve conflicts if enabled
Date: Fri, 15 Jun 2012 21:08:12 -0700
Message-ID: <B4036488-1ECA-41C9-BD97-B2ABD116D54C@kilzer.net>
References: <1339769855-94161-1-git-send-email-ddkilzer@kilzer.net> <7vwr38bmj5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 16 06:14:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfkOf-0000Av-FL
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jun 2012 06:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848Ab2FPEN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jun 2012 00:13:57 -0400
Received: from nm17-vm1.bullet.mail.ne1.yahoo.com ([98.138.91.34]:31439 "HELO
	nm17-vm1.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750781Ab2FPEN4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2012 00:13:56 -0400
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Jun 2012 00:13:56 EDT
Received: from [98.138.90.53] by nm17.bullet.mail.ne1.yahoo.com with NNFMP; 16 Jun 2012 04:08:10 -0000
Received: from [98.138.226.30] by tm6.bullet.mail.ne1.yahoo.com with NNFMP; 16 Jun 2012 04:08:10 -0000
Received: from [127.0.0.1] by smtp201.mail.ne1.yahoo.com with NNFMP; 16 Jun 2012 04:08:10 -0000
X-Yahoo-Newman-Id: 91926.38494.bm@smtp201.mail.ne1.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: Yq.DTfIVM1k1EC2wIrf_sHv_DWXWXS7d9.8y8hI6OdrrXn.
 AMbv4nyA7EuZ0ECYeu1mGpTeU_175fzW4Jv4zk4.EwZZZpqXgZBS4BifZTJP
 .rHE.jt520_qljwU6Bpm4vXt7mOlenPmuNBvmbIZ.YN9EXOUDk3nnXmBIoCa
 afVnZLL9DgVqcBPBWNOUqugJ8u_G9.SS6xs4t6jJydDe4lEZfqM83T7_RYrf
 SPGyFJW9nGEX3HCS9qd_jd9ZXHK.4AYuhqKhIarh7a8_0S57maFmeIdZhg5K
 qB477Na2D_aOcCuz8nhdxoiFR0XTx7ObF40xHmv3._q0NuLAHxhT5Txzsu8z
 ClURou.i7PnmURPMJ4h88DHc.RXSalpGcxC8ecjwlaqkYPr54l1mV1jxQucG
 fTqd8lFEnPFah.jP3kDfUWL08E5QhiE0pIel1IACmddkQ3qg-
X-Yahoo-SMTP: 1KOiJh.swBAFCIHbgY4jfyoPcdmG
Received: from kilze0-204.kilzer.net (ddkilzer@98.207.50.178 with plain)
        by smtp201.mail.ne1.yahoo.com with SMTP; 15 Jun 2012 21:08:09 -0700 PDT
In-Reply-To: <7vwr38bmj5.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1278)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200108>

On Jun 15, 2012, at 8:52 AM, Junio C Hamano wrote:

> "David D. Kilzer" <ddkilzer@kilzer.net> writes:
> 
>> From: "David D. Kilzer" <ddkilzer@kilzer.net>
>> 
>> When performing an interactive rebase that preserves merges with
>> rerere enabled, the --rerere-autoupdate switch should be passed
>> to git-merge.
> 
> I do not understand the above reasoning.
> 
> "rerere" is enabled in "merge" used in this codepath already, so
> after it runs, you will see the result of automatically replaying
> a previous resolution without your patch.
> 
> The configuration rerere.enabled *never* meant that the user blindly
> trusts the result of replaying a previous resolution.  If you were
> checking rerere.autoupdate configuration variable, the patch may
> have made some sense, but basing the decision on rerere.enabled
> (which by the way is not necessary to trigger the rerere machinery
> these days, as long as $GIT_DIR/rr-cache/ directory exists) sounds
> very wrong.

Thanks!  I'll repost the patch based on rerere.autoupdate for further discussion.

Dave
