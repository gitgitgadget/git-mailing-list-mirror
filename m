From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] cherry-pick: add support to copy notes
Date: Wed, 29 May 2013 06:18:33 -0500
Message-ID: <CAMP44s2aAvzeTtHb=rVP1TrCMcQjyqN6O7n1DYZLx0uJrm1j+w@mail.gmail.com>
References: <1369745947-19416-1-git-send-email-felipe.contreras@gmail.com>
	<1369745947-19416-2-git-send-email-felipe.contreras@gmail.com>
	<7vobbv119k.fsf@alter.siamese.dyndns.org>
	<87mwrfx9ug.fsf@linux-k42r.v.cablecom.net>
	<51a56bef1b9c2_807b33e1899991@nysa.mail>
	<877giixl4c.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s3vkJCr2f2zsZU++j4Wqxuefmpt8BQ9dJoP=JtTB=rgkQ@mail.gmail.com>
	<87y5ayqivi.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 29 13:18:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UheOu-0005QZ-Uq
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 13:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965711Ab3E2LSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 07:18:36 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:63914 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965683Ab3E2LSf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 07:18:35 -0400
Received: by mail-la0-f42.google.com with SMTP id fg20so8550762lab.15
        for <git@vger.kernel.org>; Wed, 29 May 2013 04:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hEgCMPCNXEkUQmQ1eCQyJv+fwapY1NecIgwOzBpJo3E=;
        b=lHg2C6c+X1XxJw5wl2F/Hf1ad8AGiJKmvSsPiWppIaFBG7778rzJGqSc9gazZGBJH7
         M8G8qEBLsf94p7g/5wkyDXI+953bmHt3xzlD96sTR5R8ck0ifGyTfgLwvQzPeAEzKFUi
         YhGTaMyTb2djl9HaUckXQFIdg5E3L6cQvh7uM80n4rZXf85/Eq8c314Pr2pdUssdm/vT
         280ATcapgAx4dkuc+5P7QRclSxYk83m3CoHvLGA56cTrpRua8QRNg013JDo+K9PTKiIR
         qSUJ0mTjpAIFtZUMEJl3nmddvweWM/Ae6NQP2nLoOB3IiQ0qKX0nJ6SyM0G+voQ+VTuh
         FOTg==
X-Received: by 10.112.156.164 with SMTP id wf4mr1311222lbb.76.1369826313618;
 Wed, 29 May 2013 04:18:33 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Wed, 29 May 2013 04:18:33 -0700 (PDT)
In-Reply-To: <87y5ayqivi.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225788>

On Wed, May 29, 2013 at 3:40 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Wed, May 29, 2013 at 3:09 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>>> Feel free to implement that. I'm just interested in 'git cherry-pick' being
>>>> usable for 'git rebase' purposes.
>>>
>>> Which would have been obvious to all but the most casual readers, eh?
>>
>> My motivations are irrelevant, the patch is good as it is.
>
> You fooled both Junio (AFAICT anyway) and me, who both reviewed the
> patch under the assumption that it implements note copying *along the
> lines of existing note copying*.  This proved to be a wrong, and
> time-wasting, assumption.

Whatever arbitrary rules you are talking about, they are not codified in tests.

If you care so much about "*the lines of existing note copying*", why
don't you implement tests that check for those? This not only would
prevent that some shmuck who is not well versed in the tradition of
"the lines of existing note copying" from breaking that tradition,
which is precisely what tests are for.

If this was done, we wouldn't be "time-wasting" here.

This patch makes 'git cherry-pick' pass all the tests that 'git
rebase' passes. Period.

Even if it was against "the lines of existing note copying", it's much
better than the current situation, which is to do ABSOLUTELY NOTHING.

If you were a productive person, you would take this patch and
implement the code that makes it align to "the lines of existing note
copying" that you care so much about, which should be easy, if the
note framework was properly implement, but you won't.

Why isn't this implemented?

void copy_notes_for_rewrite(const char *rewrite_cmd, struct rewritten *list);

If there was such a thing, other clients wouldn't need to implement
their own methods of copying notes.

But you didn't implement that, did you?

You are punishing me because the notes framework is lacking, and
because the testing framework is missing what you think is the proper
behavior.

Strike that, you are punishing the users.

-- 
Felipe Contreras
