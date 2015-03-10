From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 4/4] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Tue, 10 Mar 2015 21:55:33 +0800
Message-ID: <CACRoPnRXH7ozCvdxLORKMAw=GwK65NzTd-e7qtvKiQHu-qAs=Q@mail.gmail.com>
References: <1425801532-8483-1-git-send-email-pyokagan@gmail.com>
	<1425801532-8483-5-git-send-email-pyokagan@gmail.com>
	<vpqk2yqcppi.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 10 14:55:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVKdI-0002pu-37
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 14:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbbCJNzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 09:55:35 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:46093 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbbCJNze (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 09:55:34 -0400
Received: by labgm9 with SMTP id gm9so1783138lab.13
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 06:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Bg/f+k5ryxL8S+3mr+U1LbqcjOk8BKdVG7yuCasJ7Ws=;
        b=SVNZQ6DpxH3C03WypfQRnOPmaqgBDQO0MQ7KQkdQP83gjVhBO74weTElApPjlMT/Pr
         kSRzpgJB4sEVmJd905Q7zRAxZ8+wnzyWkZqShUuIFuRjZ3/waLuhm7DrU6DMmA7EE48C
         Ii4qfem0MaXNmlBhNjoh8nVKPz3a2IFRaf7d7mnUUJEoh27PoN6hM5GlLqjZWqAZYrSu
         waahCc1BHtMwd11O9/+11px4hInsyKbPbyLDyyHV3ZZ6B9dah09IMNOSL/EHfQfq5LoW
         cuQj/m/k4MNNjIXPoZFOspVvuv1bTKPrrnqDpOy9nYGdxLU2ex82C50lOV13VLOOwYFy
         +7RA==
X-Received: by 10.152.179.68 with SMTP id de4mr16212884lac.65.1425995733521;
 Tue, 10 Mar 2015 06:55:33 -0700 (PDT)
Received: by 10.112.130.228 with HTTP; Tue, 10 Mar 2015 06:55:33 -0700 (PDT)
In-Reply-To: <vpqk2yqcppi.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265238>

On Mon, Mar 9, 2015 at 8:36 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>> +'
>> +test_expect_success 'xdg credentials file will not be created if it does not exist' '
>
> We usually put a blank line between tests.

Okay, will do that.

>> +helper_test store
>
> That seems a bit "brute force" to me to re-run all tests several times.
> It's probably OK since the tests are quite fast though.

The credential helper tests are re-run because I believe that tests
should make no assumptions on the underlying implementation. e.g. the
presence of the xdg file only may activate a code path that causes
credential storage to succeed but retrieval to fail.

>> +test_expect_success 'set up custom XDG_CONFIG_HOME credential file' '
>> +     XDG_CONFIG_HOME="$HOME/xdg" && export XDG_CONFIG_HOME &&
>> +     mkdir -p "$HOME/xdg/git" &&
>
> I'd spell that "$XDG_CONFIG_HOME"/git instead, but that's not really
> important.

Okay, will do that.

Thanks for the review.
