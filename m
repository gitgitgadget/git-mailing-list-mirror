From: Stefan Beller <sbeller@google.com>
Subject: Re: git fails updating submodule only if --quiet is specified
Date: Tue, 22 Mar 2016 15:02:04 -0700
Message-ID: <CAGZ79kaYT=Sj+boEqX=mdSM2+g7cwDQucQpyvO_KmcABBF=nAg@mail.gmail.com>
References: <3E1D841C-7665-43DB-A0F8-99999C59C28D@googlemail.com>
	<219B1DC5-8379-4FD5-8739-D99890362769@googlemail.com>
	<CAGZ79kZaV3w5TM+FPORcFOdeCY8idCYV_yB4Vt5eSNVrNomp2w@mail.gmail.com>
	<CAGZ79kb0izRAZoQaDxTjKNz0VFEBqbkCSmro2pHm_kmLpJk0mw@mail.gmail.com>
	<CAGZ79kZAMwZz3w-shT_Z3itbKQWzhW2fmUzh=-gRg0Db7gRV6Q@mail.gmail.com>
	<CALgWkErHQ=coXRpzxY0jQoAN1pM-X9-UbPQUbNE56xhnb2VHfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: maddimax@gmail.com, "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 22 23:02:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiUNU-0006Wk-J5
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 23:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbcCVWCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 18:02:08 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:35001 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbcCVWCG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 18:02:06 -0400
Received: by mail-io0-f169.google.com with SMTP id o5so494020iod.2
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 15:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to;
        bh=mDT4J8I2wgmgUtc7wUPXqmv0P9u4xBRVB51AYnGdsOU=;
        b=lWDGsaWNkKpUPBnxq5TaKDxIGBl4ZQ9Nc/lS1sy8ZziU8N9ouFuySV4B0d0eOPdqVA
         cixeWLJlMiFuCv902vWQ50pViJtv+hM0XEr3EVVW/EJP3njLaPVYk4IqOiIifep2yZZE
         7L/vIfpD76s441S+m8qM6m1KeRedMRsexUnlDu/Xz+cCtg04ogA7h76Iya+Yqxlx5D/X
         FsWAJhCdR9awXqvoCbc3tfpDO6XSVtnBAe2kgfp/x+WpvR6pogxC8nNBVl+zqLRux9a0
         mYUGKj4QzyPiBkYo5Ca7wrl5CPxOaABEpqe9OwZHKj3lLymvdE2G5imo2oR9VgKar42p
         JTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to;
        bh=mDT4J8I2wgmgUtc7wUPXqmv0P9u4xBRVB51AYnGdsOU=;
        b=cys5LkD8pdTrQkvCDDWU70BMBpFO++0moEBvKKC5f8kCy2U5NOUT0r2XgYATIF9BqE
         crCYoQifrIZ8JKMHHvkt3SZ5Cu8TVf4r8VY9YH/4C6ZJhXvMC0BbPB5STsIgurTNtsWB
         JbblMULTf4zAeXiecJEcPLAB2r+D6l37ZhGyFytS7V+A9q9Agl3gbuIebVi6ec2bqFiL
         IPe8jOE1PK/jCOUwgz/3ZsiyLxW5uN0DVo/IXoFvBFjEvMNCajbOd0YQzmvDmhSr+dLd
         lHvg853OLGz6svMpMbsrsIYUJY3D1Z+0nA0HG1mCVhi83mgsuYxPvur+BPE8zov4nVXW
         RSQw==
X-Gm-Message-State: AD7BkJJVfUudskCyXZxTQCZGE9H5fQkhUEBbnECRTU4plyIKIhMfxQXJGJPum2+Jg5ef5ZWFmHsSf8wUpIMI7fN2
X-Received: by 10.50.43.226 with SMTP id z2mr24399igl.94.1458684125007; Tue,
 22 Mar 2016 15:02:05 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Tue, 22 Mar 2016 15:02:04 -0700 (PDT)
In-Reply-To: <CALgWkErHQ=coXRpzxY0jQoAN1pM-X9-UbPQUbNE56xhnb2VHfg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289573>

On Tue, Mar 22, 2016 at 2:59 PM, Marcus T <maddimax@googlemail.com> wrote:
> I should mention that I first ran into the issue in Git 2.5.0. I updated to
> 2.7.4 in the hopes that it had been fixed already.
>

Does that ring a bell for anyone?
