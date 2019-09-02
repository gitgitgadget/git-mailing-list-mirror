Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25F721F4B7
	for <e@80x24.org>; Mon,  2 Sep 2019 13:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfIBNqN (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 09:46:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:37983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfIBNqN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 09:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567431962;
        bh=uJCInJAy65uzBvjrnTFuVPG1r/rxJC0UBXpZO/MDzVw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZmP4xiP5io88IwJuwS8o33CtNYaGI0rmQkZ/mDlGfodELKZJJZsvZog98J4lL4PPG
         hxX4cp3nB4Wya/nIrgFnpwkcz/U5fbk3nD9Vplq4PsD/Au4Yghyk3mRttZs8eLkVok
         SXUIySmyERQpJbwS4dMYOHgAlfoxkBAvI7g+1m6k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LZzKf-1iRlXr1nOX-00loLt; Mon, 02
 Sep 2019 15:46:02 +0200
Date:   Mon, 2 Sep 2019 15:46:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Wong <e@80x24.org>
cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 03/11] hashmap_entry_init takes "struct hashmap_entry
 *"
In-Reply-To: <20190830194855.45jwupvp5uqcg46y@dcvr>
Message-ID: <nycvar.QRO.7.76.6.1909021542160.46@tvgsbejvaqbjf.bet>
References: <20190826024332.3403-1-e@80x24.org> <20190826024332.3403-4-e@80x24.org> <557b6f18-c346-f3c8-b623-d97752586670@gmail.com> <nycvar.QRO.7.76.6.1908281655190.46@tvgsbejvaqbjf.bet> <20190830194855.45jwupvp5uqcg46y@dcvr>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZTSXXRmT11fykqlhR2N6Ba//sz/yAn5UnlGeGQWoAdrZpYgIVtE
 acKp4FJJAePGf2fKHTpS8UnzK/MVd4GCIZjl03SvVEkS7fvH6kqpbT+DigpmE82FBGoISBw
 qKS/EF/1zAJ/Exd0oFRpeIo/4puhx8xpjjPymIjmTDQyxKsnI5gx58RpDJQZ1XbfJf9wCX7
 BxYaa249LlWKysKb8LgNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NMPuMCbu0xI=:YCstAZzUemlyLffx3ccoZj
 orgMQJSwz8UT9e2+OvFsx5lbmUohAAtBAc+lZPhEGahnopA3xPdNojs7SetkZAVkGyAi74png
 Ur9chrYh0xxsuGOUBmRB6XQUTQVvQ5d2Zg+qOPC8e/GmRcGr/+vfxyD/XOt5FGdw5PHZ9OyW9
 Grgnve58vlRJZZKH7bGqgcOpg21Q6YafmXrj00jZKH7nqgEcNnng0y7w30/3jmJG+leOj1CxJ
 tvyFClQeC7Dgv9KGrrh6Kv4/qx59foZrBcLGUigaicmq4qPVS4WIA6371A12y3ws6ecruZnTu
 I2RMyziDRHKkbkmnHmZ9o6icz8HPulHQo3918oykYSN87+5ycFwJL3/uw/ih/NRvF/gUFlcGG
 jcLOF6otAzm25CgKoQJ42ODMl5EpogqCbnbecDaFpoUMjorDFNvTjGXiRiA9ZZ0vqmAphU0Rk
 v7KablkVYltfaNyTNKh89rY7Vb0b+e0GI7rouBJCTeeHKRH7ji2+OuuiRouVGTL46ivtECaYi
 Lw2TOhD7RX1dvFpmj81WOR7zfHzxLCOq49NVorde04pYjJ4homra9gxBMmJh8c6HRPYJ/vAR2
 qUaw29C6xKBMlWE27WSZI0yz4EkwzxYmFlwtSVFrza5nXGUwJYAhdo4IWGCX+sSMdTZphEPLL
 QyV6xURLJlW1yPNnCkGUCffcMhq3B73zQSdijFyuDjOUdnJOmec+SmlK7CK8zxA9vSUhBX/XK
 hW/UU+QAWZycdc5DlUCHskVVBkAiMiS5SQZ4ygxawTyyjuv9LgQ0Ois9c5brhOa7fujY9/9WN
 mHjFzg8mRJrU7AowzA5u19MMEqXDNWGO31RaiTh/x/CJpn+rGiyoThmTJDQTqjlxtfa/9MYFq
 ZnOHi4uxwD8DwuCtqAVu+b+guk7c4/j+e1NIVkSoUSf8iAkN4BXE5dPiMAqa9j/8bX+pPGkGk
 5db6hpjCYLGOxZ3ZVzYdMWnPdynfNhyQ38zlCTS89cYo1pfu4+WHRBLLn0q0VqlcsJ/oTn6Ra
 5luPEoVj6wg1EqOjS2RAqwTDHvOAEd8EugQR6h9rpegsz79kGFXZfHTJ3CfPIkk+tsON+Nu+1
 yULFmk4oV93DzXlbqn11AqZmI1jEUjueq/DxVC4b18y+KL0ecf2kH750r0DYHRmhlgXwKWPYl
 hif6VwRkouQouDWKCEHNJBAoMK2VT+YU2v1kReqUlGHJPQBWb9VCRmTMnxZSnFQZWeksY=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, 30 Aug 2019, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 27 Aug 2019, Derrick Stolee wrote:
> >
> > > On 8/25/2019 10:43 PM, Eric Wong wrote:
> > > > C compilers do type checking to make life easier for us.  So
> > > > rely on that and update all hashmap_entry_init callers to take
> > > > "struct hashmap_entry *" to avoid future bugs while improving
> > > > safety and readability.
> > >
> > > Overall I like this change. I'll need to keep it in mind with my
> > > sparse-checkout work that is adding more hashmap types.
> > >
> > > One _might_ think that this change is relaxing the condition on
> > > where the hashmap_entry appears within the super-struct, but
> > > the hashmap internals will still use void* and perform a cast
> > > to hashmap_entry for hash comparisons.
> >
> > I thought precisely the same.
>
> Yes, that's the goal I'm working towards as mentioned in patches
> 10 and 11 :)

Well, it is not exactly clear to me how memory management would work (I
have not read patch 10 or 11 due to lack of time). At the moment,
releasing a hashmap means we can simply `free()` the stored pointers. If
you drop the requirement to make the `hashmap_entry` field the first
field of the enclosing `struct`, that is no longer possible.

Of course, you could add an `offsetof` value to the hashmap that says
what number we have to subtract from the stored pointer before calling
`free()`, but that sounds quite a bit more fragile to me than the
current design.

> > Maybe we can get a Coccinelle rule that verifies that `struct
> > hashmap_entryh` fields are always the first ones?
>
> At this point, why?  Given the goal is to remove that requirement
> entirely.

With a Coccinelle rule, we could maintain a simple design *and* be
certain that no user violates the assumption that the `hashmap_entry`
field is the first one in the enclosing `struct`.

Ciao,
Dscho
