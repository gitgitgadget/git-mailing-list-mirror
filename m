Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B99C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 21:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241837AbhLGVhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 16:37:23 -0500
Received: from mout.gmx.net ([212.227.15.15]:33427 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231451AbhLGVhX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 16:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638912831;
        bh=3Me+rop65e2L8RSDCEbRIC4vA3AvyVPv6/ykzs5WS5o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eg3e1/S4KRQ5WSrSQLilEpSH8E/jK9b3BGX9Ah5DsG/gPlVe/Vdx9k6TUQb/wQ+s9
         noNZNkyuUkfHJTbB2PeipIbmmxV8UBP8mpOk0uKOYWmRZu50B3JvMUb7f1d7TeRevT
         fFdSbzM/ibydADih29EbqepnkBATkjsx4P9DJ9Kg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([89.1.212.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLR1V-1nBPdF3npz-00IUGU; Tue, 07
 Dec 2021 22:33:51 +0100
Date:   Tue, 7 Dec 2021 22:33:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Neeraj Singh <nksingh85@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-compat-util(msvc): C11 does not imply support for
 zero-sized arrays
In-Reply-To: <20211206222539.GA27821@neerajsi-x1.localdomain>
Message-ID: <nycvar.QRO.7.76.6.2112072217280.90@tvgsbejvaqbjf.bet>
References: <pull.1094.git.1638823724410.gitgitgadget@gmail.com> <20211206222539.GA27821@neerajsi-x1.localdomain>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4X4vJtT0w7nptMXnX8SLQfb3tQ+zljPk/WdLaN3tbHSmoeV4y6Y
 j7nwOmYY1T9FciNxPGOCyx+oGs/EfI0iirE6p88eUV5Eh/wPooLS80HzYSe28Ghb1fxqO4D
 VbtJBKXqY4eCvbPklTbpBF/20PCr9ZweHZlIDwChUaqg+5big3lo6AGimVkk7Q2F8x7sPhs
 wu7QDREHbfQszyMTY6XrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:amUJGSw5aGg=:nbttjoeJRNSBwRQEG390Qj
 LR0TYyGcNNRULOdwkwuNyqIfx4lLaFclnpYLFzq6MNhmZHpdbTdpsovO6lFe+bFrelbog3qIy
 uO8BoHlvNSM3GiSokgWIAusUSljc7+DQGGWV0XcAk9FLwH6VuQu+NvdcmfdoszLguqzBzCQGa
 O0b7Loj4Z8aJO/5dlzt5P90K3NbTQdAzo+RSukwU4eI7nIGQ9ZO7i3FtMH+IoMxPMITM2HNk8
 Y24bMxti6EkBsp2sgzHgkWk63F6M/AUhlvVckrVZfIw6LCaJwVSAN9WDOCsgqXU/RzvStPC1+
 t27I2McAsMBz6QrXKoiGMn6t4KkNma4Lr5n/7OI8bFzu7t6EWFQyaWwqWaK/yVNzAcRoy6Wn7
 OJDLoN7sWg6snpD8SNTdnKQydcKe7/1Ug0Ytn7TXXQjuZXZivTMD69ArOZnEwA8zA7XwOzJBT
 tYMJxSsvwJs1XozpgJgBhytMvCHTjUlUlRvWPrtwgp/Qo16TvSjxpdwzTqUD9YaooxwylR4jW
 NUrG7hHIgjbBQIa8SCpvrfXRcPDa/jdSyPdcB66guaATqI1ZiSeJkT11anf3mS/otDIV5QCX2
 7aSeB/x9nXm+ma72yqKNV2lZvlX3opAAPcyg+C7Y6DWH3/f6F76PMwwUNB7AF07N1toFVAzGM
 f1nOrvdtNmONJh3ZzMkVX4rLHxX4i9nRB0zl+KOPNVz9KevuZbQz2XA0Ewts2aq5dHdNXgOuL
 M8Z/xmLrKnC+nsuzPahudxpe3xaMgytTPtgMKgwn8E2dgzis82vaa8xY0O0L/a0/N8UXnw0AX
 +NF9/BowIQISSB4NYvYsfxA9PF4OEEpDgnkrjEPc953C2Tk13xniqQIEVkNmibn0uFbxELzW2
 GZvSzxwGR62cM+7bTl97fk3G1wec/pRotF8g5ozXFklbuxgTjEWgQUubesxZsU75Zmo6HuzQx
 56+h8MMeQAzJ8sMPUmDogKgd02h3TX9Kh0xH7PhWlssmvOkEi38sJfVPBgZIC5ers+HpfR5oe
 3kB9rcI/0oIsyGT+vatZ5F3FKW/SyXW/KWPuqczNHHo1pdjV3ln2iUy8EpgZZuNJJc/mHWmxM
 umPW9FwzuEm41I=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Neeraj,

On Mon, 6 Dec 2021, Neeraj Singh wrote:

> I'm a little confused by this issue. Looks like an empty flex array
> is supported here: https://godbolt.org/z/j3ndYTEfx.

It is somewhat strange, but understandable, that the empty flex array at
the end of a struct isn't triggering a compile error. But having a field
_after_ that empty flex array _does_ trigger a compile error:

struct MyStruct {
    int x;
    int flexA[];
    char string[256];
};

Note the added `string` field.

See https://godbolt.org/z/TbcYhEW5d, it says:

	<source>(5): error C2229: struct 'MyStruct' has an illegal zero-sized arr=
ay
	Compiler returned: 2

> (Note that I'm passing /TC to force C compilation).

Yes, `/TC` is one of the flags we pass to MSVC. For more details, see
https://github.com/git-for-windows/git/runs/4389081542?check_suite_focus=
=3Dtrue#step:9:125

> Also, heap_fsentry doesn't appear to use a flex array in current sources=
.

It does, but it is admittedly a bit convoluted and not very easy to see.
The definition of `heap_fsentry` is
[this](https://github.com/git-for-windows/git/blob/v2.34.1.windows.1/compa=
t/win32/fscache.c#L77-L80):

	struct heap_fsentry {
		struct fsentry ent;
		char dummy[MAX_LONG_PATH];
	};

No flex array here, right? But wait, there is a `struct fsentry`. Let's
look at
[that](https://github.com/git-for-windows/git/blob/v2.34.1.windows.1/compa=
t/win32/fscache.c#L43-L74):

	struct fsentry {
		struct hashmap_entry ent;
		[...]
		/*
		 * Name of the entry. For directory listings: relative path of the
		 * directory, without trailing '/' (empty for cwd()). For file
		 * entries:
		 * name of the file. Typically points to the end of the structure
		 * if
		 * the fsentry is allocated on the heap (see fsentry_alloc), or to
		 * a
		 * local variable if on the stack (see fsentry_init).
		 */
		struct dirent dirent;
	};

Still no flex array, right? But wait, there is a `struct dirent`. Let's
[see](https://github.com/git-for-windows/git/blob/v2.34.1.windows.1/compat=
/win32/dirent.h#L9-L12):

	struct dirent {
		unsigned char d_type; /* file type to prevent lstat after readdir */
		char d_name[FLEX_ARRAY]; /* file name */
	};

Finally! We see the flex array.

Now, you may ask why is this even correct? How can you have an empty-sized
field in a struct that is inside another struct that is inside yet another
struct _and then followed by another field_?

The reason why this is correct and intended is that `struct dirent`
intentionally leaves the length of the `d_name` undefined, to leave it to
the implementation whether a fixed-size buffer is used or a
specifically-allocated one of the exact correct size for a _specific_
directory entry.

In FSCache, we want to allocate a large-enough buffer to fit _any_ file
name, and it should not only contain the metadata in `struct dirent`, but
additionally some FSCache-specific metadata.

Therefore, `struct fsentry` is kind of a subclass of `struct dirent`, and
`struct heap_fsentry` is kind of a subclass of something that does not
exist, a `struct dirent` that offers enough space to fit _any_ legal
`d_name` (that is what that `dummy` field is for, it is not actually
intended to be accessed except via `d_name`).

> If it does start using it, there issue may actually be elsewhere besides
> the struct definition (it could be just a badly targeted compiler error)=
.
> We have code like `struct heap_fsentry key[2];`.  That declaration can't
> work with a flex array.

I hope my explanation above made sense to you.

Admittedly, it is slightly icky code, but honestly, I do not have any
splendid idea how to make it less complicated to understand. Do you?

Ciao,
Dscho
