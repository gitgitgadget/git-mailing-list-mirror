From: Luke Diamand <luke@diamand.org>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Fri, 25 Sep 2015 09:05:37 +0100
Message-ID: <CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
	<xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
	<1443150875.3042.3.camel@kaarsemaker.net>
	<699c08632232180166145f70c7f16645@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 25 10:06:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfO0t-0003JX-MC
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 10:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466AbbIYIFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 04:05:43 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34310 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442AbbIYIFi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 04:05:38 -0400
Received: by oiev17 with SMTP id v17so54485960oie.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 01:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hK5Ixh9pxkmi3v/RrOTIcuNgxdrYuZKThTAvxg8xKmk=;
        b=ccWOzOAxbA2fPzzd/YxnGktIow4YT4B85AkLz89R4VlUkETcyL3fyutmtHP3Ki3mhz
         k6DxKCdMDAjYMQuvq2/z5/4qBCKz8+w39BjcFBjN5tYA0qaPBi2NngANQ8WTFnhSBsM0
         oQaFDAat/KDomLXBnzgmqBQ9XDFONJ2GtiU/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=hK5Ixh9pxkmi3v/RrOTIcuNgxdrYuZKThTAvxg8xKmk=;
        b=hRZO/8233vf4l7HIAkVmAMzpsXcI/ne7IyLcbJUBn6J2LUzzW3igvEGv23k1tmOsnI
         Kl5eKTLuGtUoojxIFpPNL7GGw23CtQKDw/Ao3sI4wyWTyvjMNgYCw6CXyoDyJcS1JHnK
         gYIYWwtsHvZnMIBkhX2Ndt3VtKfbpIRpUCgVYmn0KuFWJQoTmwWjLryLbzGMX8lueBj1
         hcaeNx5T3fVl1NU8oFLPtgnU5f3gTk5BFoo1VwKTjrLJ9zs5Y0zLL0zrmTDmHKTEPyyx
         aw8QlBlpjynp9MCqwZdhhHESqrn7yXAaZV9CmlpFuCnuxGNfYTuQTXYf4qZ2xl8TgETV
         d68A==
X-Gm-Message-State: ALoCoQkbGsQdfFRw3aVobyx0YEFAuSlq2eAYobwrH64UCHpjPWGPDYPL2qWqxPxfbcPm5iLY1Lqy
X-Received: by 10.202.177.86 with SMTP id a83mr2183007oif.113.1443168337525;
 Fri, 25 Sep 2015 01:05:37 -0700 (PDT)
Received: by 10.60.46.38 with HTTP; Fri, 25 Sep 2015 01:05:37 -0700 (PDT)
In-Reply-To: <699c08632232180166145f70c7f16645@dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278651>

On 25 September 2015 at 08:27, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi,
>
> On 2015-09-25 05:14, Dennis Kaarsemaker wrote:
>> On do, 2015-09-24 at 17:41 -0700, Junio C Hamano wrote:
>>> larsxschneider@gmail.com writes:
>>>
>>> > My idea is that the owner of "https://github.com/git/git" enables this account
>>> > for Travis (it's free!). Then we would automatically get the test state for all
>>> > official branches.
>>>
>>> The last time I heard about this "it's free" thing, I thought I
>>> heard that it wants write access to the repository.
>>
>> It does not need write access to the git data, only to auxiliary GitHub
>> data: commit status and deployment status (where it can put "this
>> commit failed tests"), repository hooks (to set up build triggers),
>> team membership (ro) and email addresses (ro).
>
> If that still elicits concerns, a fork could be set up that is automatically kept up-to-date via a web hook, and enable Travis CI there.
>
> Junio, if that is something with which you feel more comfortable, I would be willing to set it up. Even if the visibility (read: impact) would be higher if the badges were attached to https://github.com/git/git proper...
>

It would be less intrusive for the CI system to have a fork. Otherwise
other people using git with the same CI system will get annoying merge
conflicts, and we'll also end up with a repo littered with the control
files from past CI systems if the CI system is ever changed.

>From past experience, if it's configured to email people when things
break, sooner or later it will email the wrong people, probably once
every few seconds over a weekend.

Automated testing is a Good Thing, but it's still software, so needs
maintenance or it will break.


Luke
