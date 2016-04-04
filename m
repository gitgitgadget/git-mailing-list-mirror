From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH v2 0/7] t5520: tests for --[no-]autostash option
Date: Mon, 4 Apr 2016 22:28:02 +0530
Message-ID: <CA+DCAeQaS0P=Rntv5xY97MQ-j_1ji6O+MgvmcnjVmxC3KsNfRw@mail.gmail.com>
References: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
	<vpqshz125jr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 04 18:58:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an7pL-0001RE-7l
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 18:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488AbcDDQ6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 12:58:06 -0400
Received: from mail-qg0-f68.google.com ([209.85.192.68]:33200 "EHLO
	mail-qg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617AbcDDQ6E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 12:58:04 -0400
Received: by mail-qg0-f68.google.com with SMTP id y89so18250958qge.0
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=u0gZ7N+mvmfWEfAhOvPdPt3I5/UBNOF5Lev6do7SxJ4=;
        b=uIjcWL/RYJ+8ENkkzgFwh/w+3ugULCOox2HffNmaMBjMIJDDe1CuNjJp+e7Gud1ylO
         FS02A70wMhEi9YaQ85HkJd06iyw2ZNza5sHn2YqIeTYSpchqGERM6WjH6+3dWukI0bDg
         fp56JM0A0y7bx/eaJ8AqGhIE+ZT+I7lmXmS6dBVnP+uGun2G1YHZ6n6nEOje+y8RtYHb
         jbmWI0kMDOO1mvoJwjQ+3EzrbOJEDRQZ7X6S3nR++uFL/oYoM0/K07vqMmsJGB5WwPag
         pUzktQ8AXU1FrQlpdmaWaCbqVlGK5XCCnC/a98HG9W+4NCZ/wUx7cMfQm0d1+8NpsUeK
         8urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=u0gZ7N+mvmfWEfAhOvPdPt3I5/UBNOF5Lev6do7SxJ4=;
        b=PbnPmwR1YNB1GrowA6y5QHnxhwbHbaUgehd+a9kcWIl0VmqmvEqSMUuT3rnECh+y8e
         BgDCGdvkprF0H90abDylTijk8Os2x6tJKzr8yKbtA321SyEAj3tGy121cVIzyOuIljdZ
         MQpF2CBAhrO2gcg4AJAdJaZexv1VpFdzD4u5kpNE9oLtxVFAKLVvVe/1QS+qq0eJCfjW
         B299naceiMAUvOFD/bqMhPYo0wqEuuNjLeYtVrMB0QYeixzYxDpq8+eDQiDYQJWQcian
         4SFhXiXUblxFkauixAhzEY7G2th+NOb3+kGlSF2Q8vcwO2AKF4/14Lc3zyb3TfvN38PU
         oC9A==
X-Gm-Message-State: AD7BkJLG68dWXF4WmrbqjU9oQS+NFn3wUfetQ5DViXilf97cNEYEIIRp36XizaE/B3j/E33WE23NSauiKxkOoA==
X-Received: by 10.140.42.39 with SMTP id b36mr40693594qga.4.1459789082700;
 Mon, 04 Apr 2016 09:58:02 -0700 (PDT)
Received: by 10.55.10.135 with HTTP; Mon, 4 Apr 2016 09:58:02 -0700 (PDT)
In-Reply-To: <vpqshz125jr.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290699>

On Mon, Apr 4, 2016 at 1:01 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Mehul Jain <mehul.jain2029@gmail.com> writes:
>
>> -test_rebase_autostash () {
>> +test_pull_autostash () {
>>       git reset --hard before-rebase &&
>>       echo dirty >new_file &&
>>       git add new_file &&
>> -     git pull --rebase --autostash . copy &&
>> +     git pull $@ . copy &&
>
> Not strictly needed here, but I'd write "$@" (with the double-quotes)
> which is the robust way to say "transmit all my arguments without
> whitespace interpretation".
>
> I don't mind for this patch since there's no whitespace to interpret,
> but some people (sysadmins ;-) ) have the bad habit of writting $@, $*
> or "$*" in wrapper scripts and it breaks when you call them with spaces
> so it's better to take good habits IHMO.

Thanks for the suggestion, I will remember it. I'm relatively new to
shell and therefore didn't know much about the difference
between "$@" and $@, $*, "$*".

Now that I have read[1][2] about it, it won't be repeated.

[1]: http://unix.stackexchange.com/questions/41571/what-is-the-difference-between-and/94200#94200
[2]: http://unix.stackexchange.com/questions/131766/why-does-my-shell-script-choke-on-whitespace-or-other-special-characters

Thanks,
Mehul
