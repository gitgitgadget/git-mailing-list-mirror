From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] .gitignore: Ignore editor backup and swap files
Date: Fri, 17 Jan 2014 05:48:55 +0100
Organization: Organization?!?
Message-ID: <87fvonz008.fsf@fencepost.gnu.org>
References: <1389907164-13400-1-git-send-email-alexander@plaimi.net>
	<xmqqtxd3y43b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 05:49:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W41Mn-0002Ta-E7
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 05:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbaAQEtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 23:49:09 -0500
Received: from plane.gmane.org ([80.91.229.3]:58943 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248AbaAQEtH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 23:49:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1W41Mg-0002HP-4u
	for git@vger.kernel.org; Fri, 17 Jan 2014 05:49:06 +0100
Received: from x2f4f877.dyn.telefonica.de ([2.244.248.119])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 05:49:06 +0100
Received: from dak by x2f4f877.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 05:49:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f4f877.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:eGyQlF4S6iydAEFhamG5O9+aUYg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240574>

Junio C Hamano <gitster@pobox.com> writes:

> Alexander Berntsen <alexander@plaimi.net> writes:
>
>> Signed-off-by: Alexander Berntsen <alexander@plaimi.net>
>> ---
>>  .gitignore | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/.gitignore b/.gitignore
>> index b5f9def..2905c21 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -240,3 +240,5 @@
>>  *.pdb
>>  /Debug/
>>  /Release/
>> +*~
>> +.*.swp
>
> I personally do not mind listing these common ones too much, but if
> I am not mistaken, our policy on this file so far has been that it
> lists build artifacts, and not personal preference (the *.swp entry
> is useless for those who never use vim, for example).
>
> These paths that depend on your choice of the editor and other tools
> can still be managed in your personal .git/info/exclude in the
> meantime.

Here is a somewhat related question: if one places a file .dir-locals.el
in the top directory of the checkout with the contents:

;;; Directory Local Variables
;;; See Info node `(emacs) Directory Variables' for more information.

((c-mode
  (c-default-style . "linux")
  (indent-tabs-mode . t)))


Then all edits in the whole checkout done with Emacs in C files use the
right indentation style.  Obviously, that's a "personal preference"
setting in that it is useless for those who never use Emacs (the file
can be written/edited using M-x add-dir-local-variable RET).  It's still
providing significant convenience for a number of users while touching
only a single file.

-- 
David Kastrup
