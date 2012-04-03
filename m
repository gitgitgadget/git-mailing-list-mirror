From: J Robert Ray <jrobertray@gmail.com>
Subject: Re: rebase -p loses amended changes
Date: Tue, 3 Apr 2012 11:55:26 -0700
Message-ID: <CADb3U=4Y0njLiYC1qrYbdm+h0h8vLh78yfz_u3B6veEqCX0xCQ@mail.gmail.com>
References: <592E2EEC-6CBA-48D6-8D44-34A971DD78EC@gmail.com>
 <CAH3Anrqorf481jw6GdHqOPg9WC0rD-OraOHZ7twWRF4+oJ9X4A@mail.gmail.com>
 <87fwcpun95.fsf@thomas.inf.ethz.ch> <CAH3AnrpasFU2bLEZsAXRQu4U+=R_YyW+-yRXDfzy2JQpqf9dNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 20:55:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF8tV-0004uJ-G3
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 20:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216Ab2DCSzs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Apr 2012 14:55:48 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44683 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516Ab2DCSzr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Apr 2012 14:55:47 -0400
Received: by bkcik5 with SMTP id ik5so31308bkc.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 11:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=alQHznx3NYV/Aq8EKvAoskeUWFl/swizBrAJBGhktQc=;
        b=P2ErkkoeEOa/GbCBuWHTRtF17Ne5UC5Xx8OdIu+Imse2gQ76Iug37p3BsXLit1hQe0
         SS86al4pvhfSS6gzwozxQYnMp5ExyA1PgmfVirhOhKHkvFAPrnlzP/58ZHVCiZkteaSO
         qvIlmDxJNqq2/dtbKuZPOJG9q+pmdrjAp/d0b8H6oT2rhIWIqppQDuzCYr0Jf2/od3gv
         2J5uUHdxzrhQqH+ICqXdjs2vMz/GDNIWRBeWTqeIG5O/+QvT5VmCMJOkxN8zGZOB7epX
         RRcWl44IGFkXx5afJB0rfVucYbFAhwFp71V8MlcpvdLfRH9wuND0QWL1WT24TSoPfKWa
         CSnA==
Received: by 10.204.136.219 with SMTP id s27mr5622056bkt.116.1333479346617;
 Tue, 03 Apr 2012 11:55:46 -0700 (PDT)
Received: by 10.204.116.135 with HTTP; Tue, 3 Apr 2012 11:55:26 -0700 (PDT)
In-Reply-To: <CAH3AnrpasFU2bLEZsAXRQu4U+=R_YyW+-yRXDfzy2JQpqf9dNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194638>

On Sat, Mar 31, 2012 at 2:39 AM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
> On Sat, Mar 31, 2012 at 8:35 PM, Thomas Rast <trast@student.ethz.ch> =
wrote:
>> Jon Seymour <jon.seymour@gmail.com> writes:
>>
>>> On Sat, Mar 31, 2012 at 9:49 AM, Thomas Rast <trast@student.ethz.ch=
> wrote:
>>>
>>> I wonder if there are any really good justifications for changing t=
he
>>> content, as distinct from the comments of a merge during an amendme=
nt?
>>
>> Semantic conflicts do not necessarily show up as
>> conflicts-to-be-resolved. =A0The canonical example is when you chang=
e the
>> signature of a function on one side of the merge, and introduce new
>> callers on the other side. =A0The merge must then patch all new call=
ers
>> too.
>
> Fair enough - I was thinking that you could these with a commit after
> the merge, but I can see that's not the right thing to do, from a
> correctness point of view.

I thought there would be more concern about the silent data loss.
Instead of throwing away the amended changes I would prefer the rebase
to at least fail, if not have the problem require manual conflict
resolution.

A warning at the time of the amend could confuse or scare users. But a
mention of this problem in the rebase docs would help.
