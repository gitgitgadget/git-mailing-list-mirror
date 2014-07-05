From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git fetch sha1
Date: Sat, 5 Jul 2014 09:30:07 -0700
Message-ID: <CAJo=hJubkP-D0qnHQYdRC+bjt_2oTNNzgbgPqVG-DursARLrAw@mail.gmail.com>
References: <CABo2x6A_cA8KoFbe4Hcg0SJw+gOGeOFun3VDM1gx3ZVWK8wy3Q@mail.gmail.com>
 <CAJo=hJvjg0G+DiRhyh=9jnRTPjWma7zQv90VsW8Bx1WyvsQTLg@mail.gmail.com> <CABo2x6CJz6PSFCDfn47cVQi44-J0oHsGqzSiyBe8Kt5NgWibog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Allan Gardner <allanegardner@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 05 18:30:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3SrA-0002nY-UH
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jul 2014 18:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbaGEQa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2014 12:30:29 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:41318 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064AbaGEQa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2014 12:30:28 -0400
Received: by mail-ie0-f170.google.com with SMTP id lx4so1396266iec.15
        for <git@vger.kernel.org>; Sat, 05 Jul 2014 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=5dIZzwo9G9uZNQixOOY/tIE5LBwid2/87FWppchfOp8=;
        b=ZsijhsFde/aqY2pFRQcmtduHe4ZGIBlgzIgvwk7l2gYg+gv+wusZ0RpyDZ0MQCnwPs
         eFZceL1CwrS4Mq5sTqgkJFo+WJKgqLKX2WVfyhq6yZ4B3O+Vvi1oaGv4VCM/Z5xBVMuk
         bcvWz/awySffxLobnt731BrXwCVuDzonFOKlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type;
        bh=5dIZzwo9G9uZNQixOOY/tIE5LBwid2/87FWppchfOp8=;
        b=RGZj6CPKFE5GBDPqF6rrchV5EkZCely7O8s33EWS7UxNw2wHz/uS30vfPaojEx7Vnc
         No+KZv8AtoHswc4SOgYwrCKFXzYbFh2xQhQIKHavTnZIxDWcE8IGDzLtBOvbcuETfv4T
         M+Qi7aIltlvBA90sEoNWAAkZxR8UxzjuY4FCA+h4jO3Rq3xPDovEPnUYu/66U0GLPez+
         jcX9DbcXXqCW+kX71uWWKU1RAYHaszqeCQrlCSbJ/nsy1r/feqO8bGb5GzGNrghFpchc
         xZjun7daGqSO/VM+NJD+wq06ofQz+8eGlTLOIA4t7DoQP9wIB3xfS1+GrtuLWXNp5sn1
         4pwQ==
X-Gm-Message-State: ALoCoQm5B65QsmHvPn9dBwDZrpYfMJSHZr8/xuLCuMAdbdYkqemT1BE53Ns6wuFRwSGEdSK+AZ7k
X-Received: by 10.50.221.99 with SMTP id qd3mr26858086igc.3.1404577827504;
 Sat, 05 Jul 2014 09:30:27 -0700 (PDT)
Received: by 10.64.19.146 with HTTP; Sat, 5 Jul 2014 09:30:07 -0700 (PDT)
In-Reply-To: <CABo2x6CJz6PSFCDfn47cVQi44-J0oHsGqzSiyBe8Kt5NgWibog@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252918>

On Sat, Jul 5, 2014 at 6:05 AM, Allan Gardner <allanegardner@gmail.com> wrote:
> On Fri, Jul 4, 2014 at 10:41 PM, Shawn Pearce <spearce@spearce.org> wrote:
>>
>> On Fri, Jul 4, 2014 at 10:51 AM, Allan Gardner <allanegardner@gmail.com> wrote:
>> > Currently fetching a sha1 fails on git.kernel.org:
>> >
>> > $ git --version && uname -a
>> > git version 1.9.4
>> > Linux nixos 3.12.23 #1-NixOS SMP Thu Jan 1 00:00:01 UTC 1970 x86_64 GNU/Linux
>> >
>> > $ rm -rf test && mkdir test && cd test && git init
>> > Initialized empty Git repository in ~/test/.git/
>> >
>> > $ git fetch --depth 1 https://git.kernel.org/pub/scm/git/git.git
>> > 782735203c316041df120748e5e88c1787cdf4da
>> > error: no such remote ref 782735203c316041df120748e5e88c1787cdf4da
>> >
>> > I tried with head, same error. However, if I clone the full repository
>> > and then manually execute git upload-pack, it successfully fetches the
>> > commit:
>> >
>> > $ git fetch https://git.kernel.org/pub/scm/git/git.git master
>> > <wait an hour>
>> > $ git checkout -b sha1 782735203c316041df120748e5e88c1787cdf4da
>> > $ printf "0045want %s multi_ack_detailed\n000Ddeepen
>> > 1\n00000009done\n0000" "782735203c316041df120748e5e88c1787cdf4da"
>> >>input
>> > $ cat input | git upload-pack --stateless-rpc . > output
>> > $ sed -z "s/.*0008NAK\n//" < output > output.pack
>> > $ git index-pack output.pack && git verify-pack -v output.pack | grep commit
>> > f239687a5dbbd1bbb761d09edec582418c66c297
>> > 782735203c316041df120748e5e88c1787cdf4da commit 374 234 12
>> >
>> > So theoretically this is supported server-side. Unfortunately
>> > kernel.org does not agree:
>>
>> No, it is not supported server side. Your test didn't even test what
>> you think it tested.
>>
>> $ curl https://git.kernel.org/pub/scm/git/git.git/info/refs?service=git-upload-pack
>> 2>/dev/null | head -n 2
>> 001e# service=git-upload-pack
>> 0000009b6f92e5ff3cdc813de8ef5327fd4bad492fb7d6c9 HEADmulti_ack
>> thin-pack side-band side-band-64k ofs-delta shallow no-progress
>> include-tag multi_ack_detailed
>>
>> The capability you are asking about is allow-tip-sha1-in-want which
>> does not appear in the server advertisement. So its not supported on
>> this server.
>
> $ git upload-pack --advertise-refs --stateless-rpc .
> 00d16f92e5ff3cdc813de8ef5327fd4bad492fb7d6c9 HEADmulti_ack thin-pack
> side-band side-band-64k ofs-delta shallow no-progress include-tag
> multi_ack_detailed no-done symref=HEAD:refs/heads/master
> agent=git/1.9.4
>
> I did not ask about allow-tip-sha1-in-want,

I think you did. You asked about passing a random SHA-1 to `git
fetch`. The client will only send this SHA-1 to the server if an
advertised ref exactly matches or the server advertised
allow-tip-sha1-in-want. Otherwise, it errors out.

> and it is not enabled by
> default. It appears that the server must advertise no-done though,
> which indeed git.kernel.org does not.

no-done is unrelated to passing a SHA-1 on the fetch line. The two
concepts have nothing to do with each other. I seriously doubt anyone
piggybacked additional features onto no-done years after it was
introduced.

> So my next question is how
> git.kernel.org can set up the smart HTTP protocol without using
> --stateless-rpc; I guess I will have to ask them.

Haha!

Good luck with that. Current implementation requires --stateless-rpc
to run smart HTTP.
