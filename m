From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 07/14] revert: Introduce struct to keep command-line options
Date: Tue, 12 Jul 2011 11:51:56 +0530
Message-ID: <CALkWK0mxXwvurJzDOYOdXS33cb563WnKmG1_cue6F4pgqOU_WQ@mail.gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-8-git-send-email-artagnon@gmail.com> <7vzkkrjec2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 08:22:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgWMR-0007Zj-Hb
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 08:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247Ab1GLGWS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jul 2011 02:22:18 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39255 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab1GLGWR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2011 02:22:17 -0400
Received: by wyg8 with SMTP id 8so3029284wyg.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 23:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=sj7wAU92p2HOmsMFpKDWUsp2Q8JxNqnN1eTgeTc96rc=;
        b=aEoNey6QuGADv/fiSRqUioOyeh/R1dCtEh8hAc5y7DKRJoHoTSiZZ/kI2Qf1zswp5h
         jRR33AfY/yJc4HGcP4P5Szp0vSLyGQJ+R5Y33naYq2hmi2vm4Me2LvxhA0Q6rlBUh/Yb
         fml7j2GotXYahkTbMX4wyWOrYIcfl9gZHkqN4=
Received: by 10.216.8.204 with SMTP id 54mr3433838wer.92.1310451736284; Mon,
 11 Jul 2011 23:22:16 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Mon, 11 Jul 2011 23:21:56 -0700 (PDT)
In-Reply-To: <7vzkkrjec2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176926>

Hi Junio,

Again- intended to reply to this earlier; sorry.

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> The variable "me" is left as a file-scope static variable because it
>> is not an independent option. =C2=A0"me" is simply a string that nee=
ds to
>> be inferred from the "action" option, and is kept global to save eac=
h
>> function the trouble of determining it independently.
>
> Would it make more sense to remove the variable, pass "action" around
> where only "me" is passed around right now, and introduce a function
> "static const char *action_name()" to help places that wants textual
> command name for display purposes?

Okay, let me put it like this: "me" exists because cherry-pick and
revert functionalities are mixed in the same file; builtin/revert.c.
In future, the sequencer in general will support many more actions --
and we will definitely require an "opts->action to instruction sheet
keyword" translation, and that'll probably be some sort of struct.
Since I'm not sure the function you propose will make it to
sequencer.c, I don't want to introduce it now.  Let's wait and see how
it shapes up.

Thanks.

-- Ram
