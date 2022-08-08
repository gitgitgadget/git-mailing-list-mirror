Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DBEC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 13:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242958AbiHHN35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 09:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238014AbiHHN3z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 09:29:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AA49FE7
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 06:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659965387;
        bh=s8hiqAbFsQ+R9H4LU8mLzTVFX3/1bhyusCg8vQedXF0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aEuVyZDPEf3gPtwHErzpwxe4/9sK9kY1l0ZHNAt896qDXyfEPFn0UIqP9cn/Nshdq
         WK/mzjuL5wkjjN5Dj1GcOpDbDJqHXkobbzpfs5/1jku5fKyvE+sxD3RERdkzm9muA7
         GtvPkuxLJ2mB/26soUxLn6xOkQdCqdVl8CBnJbrI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.21.182.192] ([89.1.214.151]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6ux-1nbIci0GhH-00pdKy; Mon, 08
 Aug 2022 15:29:47 +0200
Date:   Mon, 8 Aug 2022 15:29:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] Allow debugging unsafe directories' ownership
In-Reply-To: <8rqqnqp1-q613-ron6-6q8s-n7sq57o980q9@tzk.qr>
Message-ID: <14q05972-5507-21n5-p61o-qq62366n6nsp@tzk.qr>
References: <pull.1286.git.1657700238.gitgitgadget@gmail.com> <3480381b8b99142bcc0213957a43d68a962c52d9.1657700238.git.gitgitgadget@gmail.com> <xmqq5yk0dcvk.fsf@gitster.g> <xmqqy1wv2x1n.fsf@gitster.g> <8rqqnqp1-q613-ron6-6q8s-n7sq57o980q9@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OlVZ2QhpzCW2WHS6l8gi+NVWqV2yfN2l40eQ2dWYHgKgGJkAeUN
 Z+L8ZabldYRbPndSfV8NEbjZwCs0TjYsztkmBgK3nr37g5eXxGp1iCm3Q/XIKe+oywxNHoi
 cJB+F1Q6vEDG4EnbdBBOoCDhXmFoEWthlTt2m3tF8O+ofA1utt8xFCa0oF4st1BTRsDwvi3
 jvkVBkFLG4H9x/0mYNZuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Mh1AiQS+X8=:5v9R2bnamldMAgFiGI+V19
 v5IdZDMjv0/GPx4VDGYjhWS5bmT7AQTzkcLGHEqJpFAL7V7dXal5azz62boLXUyNfNXQ3OtIW
 UR9YF7KwG0C6djjul/GSIUcG8EPw7mmhKuQEw5RsNDL1pqJ8ZfR/Z58o8g4U7LwrL2bjqBwmy
 yWYqDRmeVQ+FE5Rh9KYElfmIXkzvgkYfGpJPTL5sIogk7fU1LwXWYZTeurrvkOYYc/c5nXwDr
 /pd2+LY/v4HmAIIDnCfFgdxrvvQpmQB3lrdiz2079eqnDaABZHPMrYWeYDFoT4p39JY97SIny
 TfpIzwZaWRkMotRF/hVNvUdHF+j53n65oANXl2jnucmmmOS0vyxPZlTr9hAX4Ab0SYrhnHTKR
 9L/Ni/C5PW8poalkgC1FwQF+nup5OmAIp2Xc5Pt/mwxe50ElV/NydsicpRwP1IiiBcNSyenAU
 OiC7oo3+zFqrnRwivmOjD3nUhOL5SruqTlvXVk95Kl47Awep7K79ChKDPHtbvIKQ+hbZWOPHL
 mytc+opjN6b1h5caJIzEIJYnCndiPHPjilVYkhRNGiEOiw3Fv/4XYbaA54kdAXVX+CzRXJ3ug
 sm4AhI6LNDrhePwqdBnm3VXalo1R8vSqu5lYGMS7dxZIphXkaBjRYyAtqu217paB6o+OpH3oU
 BiwnZ1m4veMqUMwH7wqgIV8PKeauEXmvDLFMFIJ0lhU+wQsidfjzto/ltwc9xPfWMdGHpzsOg
 DiilFSh/ahXCL3bsg/euPi3eMJ8AA4XpJAz55+Mj+w3qBlhwCkumgqJwFhXS2V5LocuAIct2Z
 Qw0Nx/HZFQKYzcFy4M4X/zEYBMg7tyWeW7fuLTqOaTYeNVAj7anzl9lHuQ68dC4uiUqoNhxwK
 /Sp6aLtqBhxXcRvgyngQgDx5jXrKw+qLFrSLZsobW63xxvV1NgD/uay4b83vZp1RsvHc7w6gA
 auF3sgh4aHJO6NOXwLoyyviqGpaDT9KeAbgeYrWfAST0WmFe0rmpzjo6BefEv+EjK2hwGgoRN
 GmRH2m8kC5U4CGMVNK/l6LQZVqXxkCop8VHWUcuFzoN7z0KORGlkldWzHJ3bI51GPjIMwSpQL
 YfXnigyBfbx6DAcFCwFnRzqZ7buiFerbm96QWtlCPhO27Ii6Sl7vKtXnw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 15 Jul 2022, Johannes Schindelin wrote:

> On Thu, 14 Jul 2022, Junio C Hamano wrote:
>
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > ... I am not sure about this part.  Do we have any other codepath to
> > > show "to debug, run the program with this" suggestion?  Adding it in
> > > the documentation is probably good, but this is an extra message
> > > that is much larger than the "owned by X but you are Y" message that
> > > would be shown.  With or without the environment set, the output
> > > will become noisier with this patch.  I wonder if we are better off
> > > giving the information that is given in the warning (in compat/ part
> > > of the patch) _unconditionally_ in the message, which would make it
> > > less noisy overall.
> >
> > I am wondering if passing a struct to allow is_path_owned_by*()
> > helper(s) to report the detail of the failures they discover a
> > cleaner way to do this.  To illustrate what I meant, along the
> > lines of the following patch, with any additional code to actually
> > stuff messages in the strbuf report, in the is_path_owned_by*()
> > implementation.
>
> I like it! Let me play with this, after this coming week (during which I
> plan to be mostly offline).

I had to play with it for a while until I could make it work, but
eventually I managed to do it. The second iteration was just sent, and
implements this route.

Thank you,
Dscho
