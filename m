From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] pull: handle --log=<n>
Date: Wed, 13 May 2015 22:03:22 +0200
Message-ID: <vpq3830kzxx.fsf@anie.imag.fr>
References: <1431508661-21729-1-git-send-email-pyokagan@gmail.com>
	<1431508661-21729-3-git-send-email-pyokagan@gmail.com>
	<vpqlhgszujc.fsf@anie.imag.fr>
	<c8dc145fcc56d38e04fc0e07ceb34999@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 13 22:03:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yscsb-0001Vz-9b
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 22:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbbEMUDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 16:03:36 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57972 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934442AbbEMUD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 16:03:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4DK3Jw3011555
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 May 2015 22:03:19 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4DK3Mkk001938;
	Wed, 13 May 2015 22:03:22 +0200
In-Reply-To: <c8dc145fcc56d38e04fc0e07ceb34999@www.dscho.org> (Johannes
	Schindelin's message of "Wed, 13 May 2015 14:23:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 13 May 2015 22:03:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4DK3Jw3011555
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1432152202.40762@IIyDu5309YxBtP5I2Azjxw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269005>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Hi Matthieu,
>
> On 2015-05-13 11:38, Matthieu Moy wrote:
>> Paul Tan <pyokagan@gmail.com> writes:
>> 
>>> -	--log|--no-log)
>>> -		log_arg=$1 ;;
>>> +	--log|--log=*|--no-log)
>>> +		log_arg="$1" ;;
>> 
>> I think you actually don't need the double quotes here (var=$value works
>> even if $value has spaces IIRC), but they don't harm and I prefer having
>> them.
>
> I am far from a shell expert, but IIRC "$1" converts all whitespace to
> single spaces.

In most places, $1 is split before being interpreted, but there are
exceptions and actually the RHS of assignment is one of them. Just for
curiosity, I digged a reference:

https://www.gnu.org/software/autoconf/manual/autoconf-2.67/html_node/Shell-Substitutions.html
http://unix.stackexchange.com/questions/68694/when-is-double-quoting-necessary

> In general, you therefore want to quote arguments, just in case.

Yes, and one benefit of quoting anyway is to avoid having to have the
discussion we're having ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
