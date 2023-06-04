Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BADDC7EE29
	for <git@archiver.kernel.org>; Sun,  4 Jun 2023 12:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjFDMNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jun 2023 08:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjFDMNT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2023 08:13:19 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8344EC4
        for <git@vger.kernel.org>; Sun,  4 Jun 2023 05:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1685880787; x=1686485587; i=l.s.r@web.de;
 bh=7QnWbqtoK4HY4qZ9dPEX27XusxCKYUaWdpkVMWnMlp4=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=cDQxZHoVrDm+FOg/iI8yX2nLq0BhOu5HS0kMBJ7cdL8rFgQYnh4/Kfbpwqos40WnfAcVkeY
 MVeBuZM6kB1mkny7DpuGihHYePJga7Djg1x26n5QyIc6zzOm507ARBmMC5d/yTQgPZynX1Hrm
 xs+qUDaSpaBamEKF3E/38wbsUQB2p/VeqvT05jBCAky89QtS0OzHL7T5IJO7yVK/YsAO8WrKz
 yFJbk0ChCMAIs4J8lKa8VoaWWmlOS9WJaG82nW65rNlU6Lp5IRt5rkVzUB1RLaesmTzFdGJfZ
 F7zg/aEfvQ3oUV1aR0LVuaxX3sxuZqP89IgzKSaQpNlmB/7CDFDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.146.76]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5QqN-1q4x7u0mHd-001ONW; Sun, 04
 Jun 2023 14:13:07 +0200
Message-ID: <f5519f93-bca7-ecbc-9da3-b25ce8aef618@web.de>
Date:   Sun, 4 Jun 2023 14:13:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [BUG] Git 2.38.0-rc1 t1800 message text comparison
Content-Language: en-US
To:     rsbecker@nexbridge.com, git@vger.kernel.org
References: <022e01d8ceb5$c2da52c0$488ef840$@nexbridge.com>
 <003501d8cf8d$21ce5ba0$656b12e0$@nexbridge.com>
 <013701d90f80$692ba9c0$3b82fd40$@nexbridge.com>
 <2e3be2e9-191d-fbfd-54c6-a3958e35637c@web.de>
 <013501d98cee$e58dc980$b0a95c80$@nexbridge.com>
 <013601d98cf2$392153c0$ab63fb40$@nexbridge.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <013601d98cf2$392153c0$ab63fb40$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5btjVOuq+F+0qvsaaIs+8n0X6QfKJ7OQUE9EilB20i4+Cs+G/dz
 rdK8G00VFZ+YbRyuHM1sFFd4/6eslCNkUlGoK1487DkXS3zhlP5t5R+GerB3uLPscmf7Jh6
 fQqFKIQqqXqDHmg4iAfA5sPQTJSlrqyrvaY3RBtO2LBnmg1PhOET4ztNLU8el8CRGzbNpSs
 esjj552cDfIiYkq9KWEcg==
UI-OutboundReport: notjunk:1;M01:P0:2pM49xh5YgQ=;cHWa/HaRLOT4NhOR6Fyw46t9d/9
 O2b2glA60tCdXbIyHUr3q0kMTfoHU30QA7mYvq3sY9+i2K+XADNdPF1UWxhlrY5FeOpdcXmL6
 k5uvTVYmTQ/HFVWg15v4FiG94P8UeFrdQDFNYFdPYK4RRruGSREmnpd9vjvmkkO2FLbKeeSFb
 l8j+R4yoS0eL+/lD1CmR2PqpdHykTVQeBnnuz2j3zUiGQo8b2+3JgjyhmRUPKc+8Pm9PdeXI/
 ZHmN15a5upNLBLXCMRnTgMppy9D7FFev4d+heyR05bxX29KI9cuNJIKy5nyMebrwTlR56eVEo
 zHOM3S0Q893mCXmPrmChUbdSEV352Y+vBv937f6h/YoQqn7r9oBc029en/wARHNQXV/JLh4KE
 OC0ej765hC5c7KZ1LYL+f0a2d6QyyttRTHLzG8oSViapmeTrLvIwSXXpK+KsYmBb+U16fKopn
 hnruWUkDRsKjLDB09JGZ+MBMg9BUeWohXfcdqO8dZjkC0tw3d4Vkgz+D73dQ+xCG30AzxsK9v
 Y8cQmbzDlrGsx2qYQylY5OJYOICLR0G0O4dpXfH3fBjSa+sY44kCQvc8y8DaJtWRexC+qOXZ8
 o3F/t6YIM/S08+OMvolXr7WSEgb3a2m4Q6u0bR3Vj7R4ThVKfuTbaBqN6IVubuTqjTJlbZg9Q
 0LzNl+qRL53FHssyT2FRoCnTyTqZR2IE0wGxkYWsEcXSDMDSHQ/J1zZ57o3LlutrRyMKBKRJr
 YCl3kD7OPIZYfQL8ClkoduKazqyH8+u5kF4PYONWACas+LYN36XzDPxZKhK61mC9SSkV7Jv3i
 kfuGppxYblqHst9QcFZMh/C6rKm4LVucmQIRYoQIeJp2MFlDKYleGwt0tOsd4ZrWbqefOulZC
 OqXlg7pzyYMKctWX3Rqo/GYwEjssiGCsc8+xn/AslDCRaUWG5JwttVcMKJ/4yawH1lgQPs08H
 ytXckxlfV/KPGh82OJpmj9ZSB88=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.05.23 um 23:13 schrieb rsbecker@nexbridge.com:
> On Monday, May 22, 2023 4:49 PM, I wrote:
>> On Monday, May 22, 2023 4:39 PM, Ren=C3=A9 Scharfe wrote:
>>> So trying to execute an executable file consisting only of the line
>>> "#!/bad/path/no/spaces" causes NonStop to report "Permission denied"?
>>> That message text belongs to error code EACCES, not to EPERM
>>> ("Operation not permitted"), right?
>>
>> That should be correct, although the OS Devs I spoke to about this said=
 "EPERM". I
>> am experimenting.
>>
>>> POSIX allows execve to return EACCES if the file to execute is not a
>>> regular file and executing that file type is not supported or if
>>> permissions are missing to one of its path components.
>>
>> Part of the OS Dev's response was that POSIX is actually ambiguous on t=
his point.
>> Linux made the decision to use ENOENT. NonStop decided to use EPERM (al=
though it
>> may actually be EACCESS - I will report back.

In https://pubs.opengroup.org/onlinepubs/9699919799/functions/exec.html
I don't see how EACCES would be a valid response in this case.  And it
makes no intuitive sense -- which permission is missing in this
situation?

That doesn't change the fact that this issue needs to be dealt with in
Git somehow.

> NonStop actually does report EACCES, not EPERM. The comment at the
> front of run-command.c does describe the situation.
Do you mean the one about EACCES being reported if a directory in $PATH
is inaccessible in sane_execvp()?  That does not apply here because
"#!/bad/path/no/spaces" specifies an absolute path, so $PATH is not
searched.

> The following is a potential fix:
>
> diff --git a/run-command.c b/run-command.c
> index 60c9419866..b76e117d35 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -846,7 +846,7 @@ int start_command(struct child_process *cmd)
>                         execve(argv.v[0], (char *const *) argv.v,
>                                (char *const *) childenv);
>
> -               if (errno =3D=3D ENOENT) {
> +               if (errno =3D=3D ENOENT || errno =3D=3D EACCES) {
>                         if (cmd->silent_exec_failure)
>                                 child_die(CHILD_ERR_SILENT);
>                         child_die(CHILD_ERR_ENOENT);
>
> This does pass and should cover all POSIX interpretations.

That would misreport execution failures due to missing permissions
(think e.g. "chmod 0 file") as "No such file or directory".  So this
should be only done if really needed, perhaps guarded by an access(2)
check for verifying that EACCES is bogus, and only on affected
platforms.

Ren=C3=A9



