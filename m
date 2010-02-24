From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv4 1/6] environment: static list of repo-local env vars
Date: Thu, 25 Feb 2010 00:11:05 +0100
Message-ID: <cb7bb73a1002241511w1ed2e5e7pbc4565b81a6a1039@mail.gmail.com>
References: <1266996196-25978-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<1266996196-25978-2-git-send-email-giuseppe.bilotta@gmail.com> 
	<7vhbp64odi.fsf@alter.siamese.dyndns.org> <cb7bb73a1002241120i4bbbce0bl50460c76db0c6529@mail.gmail.com> 
	<7vocjemnnq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 00:11:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkQOC-00013q-2o
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 00:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758310Ab0BXXL1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 18:11:27 -0500
Received: from mail-ew0-f220.google.com ([209.85.219.220]:53896 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758228Ab0BXXL0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2010 18:11:26 -0500
Received: by ewy20 with SMTP id 20so1291656ewy.21
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 15:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=fidru1ElauBx3ruvR8W3WxLIHSTQKa35qHucSKbhjog=;
        b=dTVVpxFyV/MY0/DGe1NFtA73TK6bxbdUCicZe2Wo+t1hI1ctVmE7/jfgRoEohsDRYe
         AyKTQv8w9Rl01nINHjwEaLyFnVkG9MWRwBVb3RJCP3cPazUMQdNtcEicoo6t/bpZbvZ4
         BBVQn6qZJD3MfzYaLVFK+h2g98eRy8XjJIzAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Z0ncPouvdTBsEAPjFtXD88czhJBXc6J4dxqX7d2OYH/4+peaTCAb5x6IGiJO5utMdh
         2zjqB2+m/QOS546idi/HpMfv1MFCq/j8gAnsY2JVQe+MdqJWNRhsMIKfs6l4dqCaBW9E
         Cvvz/iAL04hyvHGpeC1ywUe6cAMVHQpHJiplw=
Received: by 10.213.109.219 with SMTP id k27mr803444ebp.37.1267053085118; Wed, 
	24 Feb 2010 15:11:25 -0800 (PST)
In-Reply-To: <7vocjemnnq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141001>

On Wed, Feb 24, 2010 at 8:36 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> On Wed, Feb 24, 2010 at 4:58 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>>>
>>>> +/* Repository-local GIT_* environment variables */
>>>> +const char *const local_repo_env[] =3D {
>>>> + =A0 =A0 ALTERNATE_DB_ENVIRONMENT,
>>>> + =A0 =A0 CONFIG_ENVIRONMENT,
>>>> + =A0 =A0 DB_ENVIRONMENT,
>>>> + =A0 =A0 GIT_DIR_ENVIRONMENT,
>>>> + =A0 =A0 GIT_WORK_TREE_ENVIRONMENT,
>>>> + =A0 =A0 GRAFT_ENVIRONMENT,
>>>> + =A0 =A0 INDEX_ENVIRONMENT,
>>>> + =A0 =A0 NO_REPLACE_OBJECTS_ENVIRONMENT,
>>>> + =A0 =A0 NULL
>>>> +};
>>>> +
>>>> +const unsigned int local_repo_env_size =3D ARRAY_SIZE(local_repo_=
env);
>>>
>>> This does not look very useful for two reasons.
>
> By the way, I said "frustrating" but didn't mean we should bend backw=
ards.
> The earlier one is more than Ok, and is certainly better than having
> local_repo_env_size that is not very useful in practice.

But I'd like a manually-set local_repo_env_size than the gimmicks
necessary if it's not there (plus the runtime failure). If there are
no other corrections, I'll send a new series (that also squashes the
first two patches per Johannes' suggestion) and the #define

--=20
Giuseppe "Oblomov" Bilotta
