Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56307207B3
	for <e@80x24.org>; Thu,  4 May 2017 07:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbdEDH2g (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 03:28:36 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:33446 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbdEDH2e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 03:28:34 -0400
Received: by mail-io0-f169.google.com with SMTP id p24so11545724ioi.0
        for <git@vger.kernel.org>; Thu, 04 May 2017 00:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P4Qi9SPSribUX9Y0u1FIcvnIUzRWfZTqinZPjli3gUI=;
        b=Par+Ax9EO2QXfhigPenCCXKMZ4UD1KRdZVC6LkqY6zBpbBn9HU6ByM7NiKcvcK/oK2
         HsIIefc0F6laeMRgryUyQiCqaWSf9P5lZ8erPE23a4sT+Zk+EjOpnlSOQzMZ01PV0REb
         jZ//YFWr/Vj3Svxpp7JJ2QVUyFZnnFqLwc6xW+HuO6iFF1XgGeRZmhYvgj2HSQed/GUH
         OktaTWfkq4DFRn9807eJQmyoJX0kylbY/DKMhZ1rQpW/sEQEWW7skSOpSknsHftHrOZc
         +k1ly5hUGLROOvwzfeLr+OwwvgSLj202AqemhQhI1XFRSd35ZzASPSt89ZQeqgK7x/Jr
         Wh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P4Qi9SPSribUX9Y0u1FIcvnIUzRWfZTqinZPjli3gUI=;
        b=TaNQOfy3QcAkL2QfKUp6lXt8YItssEoxH70b4/3M0hq1d8tFcRsPXko0QvsZfpJpho
         PuZPoCnpap3BKx6sg+GuK16htiarMazok1mnbrSsJIeY0QK8cNKZ/7EhxpyR19X+STSf
         aHOWrJ5xJTX+L7sibM0j9sG3dPOUSBnXUH5U7Qj37vqpl/k8oH60GUuZLjTMY/40j/Lg
         l90DP9/c2wAym/BMKsLsPUM+jwLQLxuF+Dmb3cosjHi3WCh7mgu+nNRSzX7JuNLhwXqa
         3+xgv4tTKoz+EHaQHjs6hKeQuBYXTxi68eVQ/VSXL1SKUTqFor4BZJAZ3qLtbEaOyGNd
         cOrQ==
X-Gm-Message-State: AN3rC/5/+BLHsnMZ31P5JqBpLUM/AJJYkkg9Ntz9gKqoYoDsFSsDOUEs
        ByGp3vsTFXW6+dDCjFTv1x4h8hTF6A==
X-Received: by 10.107.146.139 with SMTP id u133mr35191171iod.160.1493882913140;
 Thu, 04 May 2017 00:28:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 4 May 2017 00:28:12 -0700 (PDT)
In-Reply-To: <CAM0VKjnjMEThuMvLEQByxWvxVvdzMSVsFKKstKLMweEx5UwTcg@mail.gmail.com>
References: <robbat2-20170225T185056-448272755Z@orbis-terrarum.net>
 <20170225205052.j3p7obbf4onf6cbf@sigill.intra.peff.net> <xmqqd1e3xx4c.fsf@gitster.mtv.corp.google.com>
 <20170227211217.73gydlxb2qu2sp3m@sigill.intra.peff.net> <CAM0VKj=rsAfKvVccOMOoo5==Q1yW1U0zJBbUV=faKppWFm-u+g@mail.gmail.com>
 <20170315170829.7gp44typsyrlw6kg@sigill.intra.peff.net> <CAM0VKjnjMEThuMvLEQByxWvxVvdzMSVsFKKstKLMweEx5UwTcg@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 4 May 2017 09:28:12 +0200
Message-ID: <CACBZZX5706NELxAOWRVAx-QFPtZ_rAsRkTX811+jfrN4u47XfA@mail.gmail.com>
Subject: Re: git-clone --config order & fetching extra refs during initial clone
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 3, 2017 at 4:42 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
> Cc'ing =C3=86var because of his work on 'clone --no-tags'.
>
> On Wed, Mar 15, 2017 at 6:08 PM, Jeff King <peff@peff.net> wrote:
>> On Sat, Mar 11, 2017 at 01:41:34AM +0100, SZEDER G=C3=A1bor wrote:
>>> > Though if I'm bikeshedding, I'd probably have written the whole thing
>>> > with an argv_array and avoided counting at all.
>>>
>>> Yeah, I did notice that you love argv_array :)  I had to raise an
>>> eyebrow recently while looking at send-pack and how it uses argv_array
>>> to read refspecs from stdin into an array.  I think argv_array feels a
>>> bit out of place in both cases.  Yes, it does exactly what's needed.
>>> However, it's called *argv*_array, indicating that its contents is
>>> destined to become the options of some command.  But that's not the
>>> case in these two cases, we are not dealing with arguments to a
>>> command, these are just arrays of strings.
>>
>> In my mind, "argv" is synonymous with "NULL-terminated array of
>> strings". If the name is the only thing keeping it from wider use, I'd
>> much prefer us to give it a more generic name. All I really care about
>> is simplifying memory management. :)
>
> Whether its name is the _only_ thing keeping it from wider use, I
> don't know :)
>
> All I can say is that I was aware of argv_array, but because of
> its name it didn't even occur to me.  And even if I had considered it,
> I still wouldn't have used it here.  Had it been called string_array,
> I think I would have used it.
>
> On a related note, we have string_list, which is not a list but an
> ALLOC_GROW()-able array, and not that of strings (i.e. plan char*),
> but of structs with a string and an additional data field.
> Oh, well :)
>
>
>>> > I do also notice that right _after_ this parsing, we use remote_get()=
,
>>> > which is supposed to give us this config anyway. Which makes me wonde=
r
>>> > if we could just reorder this to put remote_get() first, and then rea=
d
>>> > the resulting refspecs from remote->fetch.
>>>
>>> Though get_remote() does give us this config, at this point the
>>> default fetch refspec has not been configured yet, therefore it's not
>>> included in the resulting remote->fetch array.  The default refspec is
>>> set in write_refspec_config(), but that's called only about two
>>> screenfulls later.  So there is a bit of extra work to do in order to
>>> leverage get_remote()'s parsing.
>>>
>>> I think the simplest way is to keep parsing the default fetch refspec
>>> manually, and then append it to the remote->fetch array.  Definitely
>>> shorter and simpler than that parsing in the current patch.
>>> Alternatively, we could set the default fetch refspec in the
>>> configuration temporarily, only for the duration of the get_remote()
>>> call, but it feels a bit too hackish...
>>
>> Yeah, I think manually combining the two here is fine. Though I won't
>> complain if you want to look into setting the config earlier. If the
>> refactoring isn't too bad, it would probably provide the nicest outcome.
>
> I did actually look into that, but don't think it's a good idea.
>
> write_refspec_config() nicely encapsulates writing the proper fetch
> refspec configuration according to the given command line options.  Of
> course these options are already known right at the start, so solely
> in this regard we could call this function earlier.  However, in some
> cases, e.g. '--single-branch', the refspec to be written to the config
> depends not only on the given options but on the refs in the remote
> repository, too, so it can only be written after we got the remote's
> refs.
>
>
> Unfortunately, there is more to this issue.  Earlier I though that the
> fetch refspec is the only config that is ignored during a clone.
> However, =C3=86var's 'clone --no-tags' patches[1] drew my attention to th=
e
> 'remote.<name>.tagOpt' config variable, that I overlooked earlier...
> and apparently 'git clone' overlooks it as well, grabbing all tags
> even when it's set to '--no-tags'.
>
> The root issue is that 'git clone' calls directly into the fetch
> machinery instead of running 'git fetch' (either via run_command() or
> cmd_fetch()), and some of these "higher-level" config variables are
> only handled in 'builtin/fetch.c' but not in 'git clone'.  By
> "handle" I mean "parse and act accordingly": as it happens, these
> config values are parsed alright when 'git clone' calls remote_get(),
> but it never looks at the relevant fields in the resulting 'struct
> remote'.
>
> Luckily, many "lower-level" config variables are working properly even
> during 'git clone', because they are handled in the transport layer,
> e.g. 'git clone -c url.https://github.com/.insteadof=3Dgh: gh:git/git'
> does the right thing.
>
>
> I'm not sure what the right way forward would be.
>
> My patch deals with 'remote.<name>.refspec', i.e. 'remote->fetch'.
> Apparently some extra care is necessary for 'remote.<name>.tagOpt' and
> 'remote->fetch_tags', too.  Perhaps there are more, I haven't checked
> again, and maybe we'll add similar config variables in the future.  So
> I don't think that dealing with such config variables one by one in
> 'git clone', too, is the right long-term solution...  but perhaps it's
> sufficient for the time being?
>
> Running a fully-fledged 'git fetch' seems to be simpler and safer
> conceptually, as it would naturally handle all fetch-related config
> variables, present and future.  However, it's not without drawbacks:
> 'git clone' must set the proper config before running 'git fetch' (or
> at least set equivalent cmdline options), which in some cases requires
> the refs in the remote repository, making an additional "list remote
> refs" step necessary (i.e. both 'clone' and 'fetch' would have to
> retrieve the refs from the remote, resulting in more network I/O).
>
> Or we should libify more of 'builtin/fetch.c', but with all those
> static variables and functions in there...  Ugh :)

Yes from my (limited) understanding of the code after hacking in
--no-tags this all seems correct. I.e. that a large part of my patch
wouldn't be needed if we were able to just set tagOpt earlier & then
call fetch.

But as you point out there's a big chicken & egg problem with the
likes of --single-branch where we'd either need to run upload-pack on
the remote side twice, once to get the branch and once to fetch (ew!).

The way to get around that that I can see would be to have some deep
hooking into the fetch machinery where first we set our config like
tagOpt=3D--no-tags for --no-tags, then we call `fetch`, but `fetch`
would need to have some hook where in the case of --single-branch it
would immediately write the branch name to the fetch spec in the
config, then do the actual fetching.
