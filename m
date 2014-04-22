From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Project idea: strbuf allocation modes
Date: Tue, 22 Apr 2014 12:38:18 +0200
Message-ID: <vpqa9bdsl7p.fsf@anie.imag.fr>
References: <vpqr457omgs.fsf@anie.imag.fr> <53512DB6.1070600@alum.mit.edu>
	<vpqr44psuzf.fsf@anie.imag.fr> <535631C0.2020100@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 22 12:38:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcY5x-0006YE-Jg
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 12:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbaDVKi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 06:38:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37527 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755807AbaDVKiY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 06:38:24 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s3MAcIkH010148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Apr 2014 12:38:18 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3MAcIqM005614;
	Tue, 22 Apr 2014 12:38:18 +0200
In-Reply-To: <535631C0.2020100@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 22 Apr 2014 11:09:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 22 Apr 2014 12:38:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3MAcIkH010148
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1398767899.1798@bawumiRLZbwXLvRtAxQ8pg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246729>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 04/22/2014 09:07 AM, Matthieu Moy wrote:
>
> The whole point of the change is to *allow* strbuf to be used in
> performance-critical stuff.

OK. It should not make the current use of strbuf any harder anyway.

>> In your proposal, would STRBUF_OWNS_MEMORY be a constant, or a flag that
>> change when the internal buffer needs reallocation? My understanding is
>> that it should change (if STRBUF_FIXED_MEMORY is not set), and the
>> strbuf wrapping a preallocated buffer would become a "normal" strbuf
>> when its internal buffer grows.
>
> Correct.  STRBUF_OWNS_MEMORY itself is of course a constant like 0x02

Yes, I meant "the STRBUF_OWNS_MEMORY flag".

> How does the size of this project compare to what you are looking for
> for your Ensimag students?

I do not yet have applications for this project (it should come within
the next few days). It greatly depends on students and team size. I
always start with a "warm up patch" (like GSoC's microprojects), and
depending on the time taken for it, I direct students to bigger or
smaller projects.

Your proposal is a bit tricky (it requires a good understanding of C and
memory management), but it is a purely local change (i.e. you can take
strbuf.[cf] out of Git's source code and hack it as a ~500 LOC project,
unit-test and document the result in a self-contained way), so it should
be doable. Using the new API features here and there in Git's source
code is another story though.

I've added the proposal with a link to this discussion here:

  https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#Allow_finer_memory_management_in_the_strbuf_API

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
