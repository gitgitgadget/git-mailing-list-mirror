From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v7 0/7] git-p4: add support for large file systems
Date: Wed, 23 Sep 2015 12:25:26 +0100
Message-ID: <CAE5ih7_m050wcWZ+7UvL3GscKgSxLWGT+bj4_gSVA8R7RZm=tg@mail.gmail.com>
References: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com>
	<CAE5ih7_PBRMgobhBATUMOaRH8yPWWnEVDiFVdk+qjRzoyPq+CQ@mail.gmail.com>
	<CE59FE83-4EE1-41EF-85B6-63EA51BD9E3B@gmail.com>
	<A29B974F-2B42-475F-92B6-8B25A54FCDEE@gmail.com>
	<CAE5ih7-NqSd+zSqTungDt5oWzy4QT--vjYaShd=YDzGxHosz3A@mail.gmail.com>
	<ECBECF84-28A9-4E10-907C-8E670F864A25@gmail.com>
	<CAE5ih7_StiXA-c5yER9jhc941vsKfvEUONLXQ4E7JANOhCxMxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 13:25:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeiB7-0001Xz-Sb
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 13:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166AbbIWLZa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Sep 2015 07:25:30 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35969 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842AbbIWLZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Sep 2015 07:25:27 -0400
Received: by obbmp4 with SMTP id mp4so30345784obb.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 04:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=uazo7686KHWmeAwcI+2TGxp6RbOI5qhs+HHcS1qa8s0=;
        b=FAsWb0bh+Pi+WoKhKs9zgbJg+wysGorZp0SVVopJDOR1EuyV58AuDclfT/DxRZzom1
         6I9WwDztCisz0ZOt4F2naaalKsm74b5TqoIyNowR4Qvf2IY30tRxV3707wj2/0pK/5U0
         I2IhoJ0d5oDVvrJwvxOb3H3gtBh/hb7KseJKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uazo7686KHWmeAwcI+2TGxp6RbOI5qhs+HHcS1qa8s0=;
        b=NrgAjnRUMBLt+/JKl2PzLSYEnY6Pvm1aTQelZI+3H0YzjiNOAb8LePB/OYzOsF0Qxe
         VFOGvQ0TU+P5XomtvA0jKy5Ct6R8XtIVlwQQp2ao/kqbxwQQcelJ+RgJeRxJSWDiv/gW
         UHf5or6GNCeQZV8UtrVBQPNe40/mcet18qdfk9aSEneasKmxkIXDydjrmmYILM1zzljp
         m49/AAsgH4zERjgbSdbh0sw1GulUsKRkx9aXCwpGQyO7eHkMVtg78mrRmJV4U7v/Omkj
         ms/lLiLJACR1z5C7AiTMoq8/VNeBeInLlN3gIPbF7TdUuKy3z0j0ZKCycgr3HpAeKiO9
         C3Gw==
X-Gm-Message-State: ALoCoQkWClTgmpubPb5T6Yt3jiAPJCmP2CDqd9ewFx0b5IYtf5Ln1BklHtCnyQDjIUHpsI+MDtBE
X-Received: by 10.182.47.202 with SMTP id f10mr18003047obn.56.1443007526447;
 Wed, 23 Sep 2015 04:25:26 -0700 (PDT)
Received: by 10.60.46.38 with HTTP; Wed, 23 Sep 2015 04:25:26 -0700 (PDT)
In-Reply-To: <CAE5ih7_StiXA-c5yER9jhc941vsKfvEUONLXQ4E7JANOhCxMxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278483>

Adding back git@vger.kernel.org, which I inadvertently dropped off the =
thread.

On 23 September 2015 at 12:22, Luke Diamand <luke@diamand.org> wrote:
> On 23 September 2015 at 11:09, Lars Schneider <larsxschneider@gmail.c=
om> wrote:
>>
>> On 23 Sep 2015, at 11:22, Luke Diamand <luke@diamand.org> wrote:
>>
>>> On 23 September 2015 at 09:50, Lars Schneider <larsxschneider@gmail=
=2Ecom> wrote:
>>>>
>>>> On 23 Sep 2015, at 10:18, Lars Schneider <larsxschneider@gmail.com=
> wrote:
>>>
>>> <snip>
>>>
>>>>
>>>> I think I found an easy fix. Can you try it?
>>>>
>>>> (in case my mail app messes something up: I changed line 2240 in g=
it-p4.py to 'self.cloneDestination =3D os.getcwd()=E2=80=99)
>>>
>>> It fixes the problem, but in re-running the tests, I'm seeing t9808
>>> fail which doesn't happen on next.
>> Confirmed. I fixed it.
>> Do you think it makes sense to create a new roll v8 for Junio?
>
> How about we leave it a day or two in case anything else crawls out o=
f
> the woodwork?
>
> Thanks!
> Luke
