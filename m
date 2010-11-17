From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Bogus error: Untracked working tree file '....' would be overwritten by merge. Aborting
Date: Wed, 17 Nov 2010 09:46:11 +0100
Message-ID: <vpqtyjgxrqk.fsf@bauges.imag.fr>
References: <AANLkTinv7XsXNR2MMbaGAUo2=WgL6SEWkuzwGU_7YVn0@mail.gmail.com>
	<20101116112406.GA18259@do>
	<AANLkTikeaj6kfq+pv+F0mOUSC7yJKnwyUgy9k8GPTpxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 09:50:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIdiN-00046f-Ki
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 09:50:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759889Ab0KQIt6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Nov 2010 03:49:58 -0500
Received: from imag.imag.fr ([129.88.30.1]:59216 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757849Ab0KQIt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 03:49:57 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id oAH8kBkI022985
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 17 Nov 2010 09:46:11 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PIded-0007R1-Gy; Wed, 17 Nov 2010 09:46:11 +0100
In-Reply-To: <AANLkTikeaj6kfq+pv+F0mOUSC7yJKnwyUgy9k8GPTpxg@mail.gmail.com> (Nguyen Thai Ngoc Duy's message of "Tue\, 16 Nov 2010 18\:34\:40 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 17 Nov 2010 09:46:12 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161604>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Tue, Nov 16, 2010 at 6:24 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.=
com> wrote:
>> +static int identical_content(struct cache_entry *ce, struct stat *s=
t)
>> +{
>> + =A0 =A0 =A0 unsigned char sha1[20];
>> + =A0 =A0 =A0 return !index_path(sha1, ce->name, st, 0) && !hashcmp(=
sha1, ce->sha1);

I do like the idea.

> Even better, do a file size check here. If it's not equal, there's no
> point in calling the expensive index_path().

I think you also need to check mode changes here.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
