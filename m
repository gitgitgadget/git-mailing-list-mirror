From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Tabs in commit messages - de-tabify option in strbuf_stripspace()?
Date: Sun, 20 Mar 2016 14:29:48 +0100
Message-ID: <vpqwpoxcm5v.fsf@anie.imag.fr>
References: <CA+55aFzHMp4hiCp7+2Yxy=KNQ_rBru3RM-pghXUPtoxr_L+w2w@mail.gmail.com>
	<xmqq4mc76yji.fsf@gitster.mtv.corp.google.com>
	<CA+55aFyXXHNrJW56A_DKkmrmGpWxeUd6row_ja3bzqhs_yswhw@mail.gmail.com>
	<CAGZ79kZihaftwwmY23mZ_i4H6vv2Z9r=LC68M0MMD1o2h2Z4Sw@mail.gmail.com>
	<CAGZ79kZtAm1M=9CGDGxPdecXEuNEQcbpQb3FNj9=Py0VE2UrKQ@mail.gmail.com>
	<56E96D61.6060007@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 14:30:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahdQn-0007T6-SQ
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 14:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458AbcCTNaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 09:30:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43123 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755446AbcCTNaE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 09:30:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u2KDTlXI026642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 20 Mar 2016 14:29:47 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u2KDTm0T012328;
	Sun, 20 Mar 2016 14:29:48 +0100
In-Reply-To: <56E96D61.6060007@xiplink.com> (Marc Branchaud's message of "Wed,
	16 Mar 2016 10:27:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Sun, 20 Mar 2016 14:29:47 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u2KDTlXI026642
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1459085389.58989@6/krf9F0q6GPy0OF7P2AfQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289353>

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 16-03-15 09:02 PM, Stefan Beller wrote:
>> On Tue, Mar 15, 2016 at 6:00 PM, Stefan Beller <sbeller@google.com> wrote:
>>>
>>> Instead of converting to whitespaces in Git, we could make use of the
>>> set_tabs capability for ttys and setup the terminal for having tabs align
>>> to 12,+8,+8,+8...
>> 
>> Or rather read in the existing tabs configuration and shift it by a constant.
>
> Could this also help with diff output, where the leading + or - mars the
> indentation in a similar way?

Hardly: the same pager would be used to display the commit message (with
a 4-space prefix) and the diff (with a 1-char +/- prefix). So the
offsets in these two places would need to be different, and I don't
think we can change that on the fly.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
