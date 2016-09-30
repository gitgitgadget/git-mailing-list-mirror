Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1063207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 18:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933560AbcI3S4S (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 14:56:18 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35328 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933512AbcI3S4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 14:56:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id f193so75344wmg.2
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 11:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jwEmWPL1Mc2+BErmOFWpstwZsiJfMgcVEejjd6LGBQ8=;
        b=YUfwNCF7n1BQICweUCeH4E9Gs4OhgnQaswcDsk5BMD81NyMUYZMbjGG78MD8agpQHU
         Ko7AjCE3FqCNF+R7HoCpK2f8Q37jpoKVOtUgihwM4AoenTQhu3xzsr9uMIEsGmahVuLU
         jEWmMZsfggPY9QsmLsJbC2VEhAk3JC3dNWlQKJgXugKgLrnXrTmOSZ76ekuBkelbcnZt
         TTtjCD37ICzoNQ5W8+quaweVT6KWsqjKXEFe+2ilbshV7A0T05krv4hSQDtLcE2/v7Dy
         eclVFVxDhcgLl6bwdKNbdfZCsqRbEf2IwrB7Hh3zx/CXLdhGgA7TBF3vQEalJDdaRGpR
         AGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jwEmWPL1Mc2+BErmOFWpstwZsiJfMgcVEejjd6LGBQ8=;
        b=i+h9Lkjivtenmmur0ZN4/dufcxmUo4IzrlIECe6bm6QLh1jHabqQRtBQ+YPLtIvTdf
         KJvi5TIKGZak8FKg5/kV1BOPDRbNrg+GvOzOiRdY1eeNqNj6PwRlrjlHvEUP6ixSMcMH
         lDk3O6NMz7UlUhAD8gOihTHrevVG2CP7sws4URuCxDmhaz3NaMLUik5E2r4i6Ar7c6nL
         UwRgARXSl7d/vDUQn7L6g9OrwFV81OafEKH+R5HvEe+oPEnXyvdtKbzVxJbFIXaYthic
         5yCFDS8U9N66kmVvLXJ8o8sQqlKA6Uy8tX/2XQaebY+/v3+G0IO0hv5C578bM8UEL9m4
         zypg==
X-Gm-Message-State: AA6/9RnAsnYzIeOlShHnQCHgvz5AysXkGWzgXMkVa0fNkorU9RVOzV1z+hYLfWbbVN1yag==
X-Received: by 10.194.200.6 with SMTP id jo6mr8389955wjc.77.1475261774939;
        Fri, 30 Sep 2016 11:56:14 -0700 (PDT)
Received: from remjtf6f32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id m75sm5525358wmi.0.2016.09.30.11.56.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Sep 2016 11:56:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 11/11] convert: add filter.<driver>.process option
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <91589466-439e-7200-7256-b9288beae685@gmail.com>
Date:   Fri, 30 Sep 2016 20:56:12 +0200
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4DE57A65-1020-4F17-81F2-9F319834BB2D@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com> <20160920190247.82189-12-larsxschneider@gmail.com> <91589466-439e-7200-7256-b9288beae685@gmail.com>
To:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Sep 2016, at 00:41, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>=20
> Part first of the review of 11/11.
>=20
> W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> diff --git a/Documentation/gitattributes.txt =
b/Documentation/gitattributes.txt
>> index 7aff940..946dcad 100644
>> --- a/Documentation/gitattributes.txt
>> +++ b/Documentation/gitattributes.txt
>> @@ -293,7 +293,13 @@ checkout, when the `smudge` command is =
specified, the command is
>> fed the blob object from its standard input, and its standard
>> output is used to update the worktree file.  Similarly, the
>> `clean` command is used to convert the contents of worktree file
>> -upon checkin.
>> +upon checkin. By default these commands process only a single
>> +blob and terminate.  If a long running `process` filter is used
>   ^^^^
>=20
> Should we use this terminology here?  I have not read the preceding
> part of documentation, so I don't know if it talks about "blobs" or
> if it uses "files" and/or "file contents".

I used that because it was used in the paragraph above already.


>> +Long Running Filter Process
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +If the filter command (a string value) is defined via
>> +`filter.<driver>.process` then Git can process all blobs with a
>> +single filter invocation for the entire life of a single Git
>> +command. This is achieved by using a packet format (pkt-line,
>> +see technical/protocol-common.txt) based protocol over standard
>> +input and standard output as follows. All packets are considered
>> +text and therefore are terminated by an LF. Exceptions are the
>> +"*CONTENT" packets and the flush packet.
>=20
> I guess that reasoning here is that all but CONTENT packets are
> metadata, and thus to aid debuggability of the protocol are "text",
> as considered by pkt-line.
>=20
> Perhaps a bit more readable would be the following (but current is
> just fine; I am nitpicking):
>=20
>  All packets, except for the "{star}CONTENT" packets and the "0000"
>  flush packer, are considered text and therefore are terminated by
>  a LF.

OK, I use that!


> I think it might be a good idea to describe what flush packet is
> somewhere in this document; on the other hand referring (especially
> if hyperlinked) to pkt-line technical documentation might be good
> enough / better.  I'm unsure, but I tend on the side that referring
> to technical documentation is better.

I have this line in the first paragraph of the Long Running Filter =
process:
"packet format (pkt-line, see technical/protocol-common.txt) based =
protocol"

>=20
>> +to read a welcome response message ("git-filter-server") and exactly
>> +one protocol version number from the previously sent list. All =
further
>=20
> I guess that is to provide forward-compatibility, isn't it?  Also,
> "Git expects..." probably means filter process MUST send, in the
> RFC2119 (https://tools.ietf.org/html/rfc2119) meaning.

True. I feel "expects" reads better but I am happy to change it if
you feel strong about it.


>> +
>> +After the version negotiation Git sends a list of supported =
capabilities
>> +and a flush packet.
>=20
> Is it that Git SHOULD send list of ALL supported capabilities, or is
> it that Git SHOULD NOT send capabilities it does not support, and that
> it MAY send only those capabilities it needs (so for example if =
command
> uses only `smudge`, it may not send `clean`, so that filter driver =
doesn't
> need to initialize data it would not need).

"After the version negotiation Git sends a list of all capabilities that
it supports and a flush packet."

Better?


> I wonder why it is "<capability>=3Dtrue", and not =
"capability=3D<capability>".
> Is there a case where we would want to send "<capability>=3Dfalse".  =
Or
> is it to allow configurable / value based capabilities?  Isn't it =
going
> a bit too far: is there even a hind of an idea for parametrize-able
> capability? YAGNI is a thing...

Peff suggested that format and I think it is OK:
=
http://public-inbox.org/git/20160803224619.bwtbvmslhuicx2qi@sigill.intra.p=
eff.net/


> A few new capabilities that we might want to support in the near =
future
> is "size", "stream", which are options describing how to communicate,
> and "cleanFromFile", "smudgeToFile", which are new types of =
operations...
> but neither needs any parameter.
>=20
> I guess that adding new capabilities doesn't require having to come up
> with the new version of the protocol, isn't it.

Correct.


>> +packet:          git< git-filter-server
>> +packet:          git< version=3D2
>> +packet:          git> clean=3Dtrue
>> +packet:          git> smudge=3Dtrue
>> +packet:          git> not-yet-invented=3Dtrue
>=20
> Hmmm... should we hint at the use of kebab-case versus snake_case
> or camelCase for new capabilities?

I personally prefer kebab-case but I think that is a discussion for
future contributions ;-)


>> +------------------------
>> +packet:          git> command=3Dsmudge
>> +packet:          git> pathname=3Dpath/testfile.dat
>> +packet:          git> 0000
>> +packet:          git> CONTENT
>> +packet:          git> 0000
>> +------------------------
>=20
> I think it is important to mention that (at least with current
> `filter.<driver>.process` implementation, that is absent future
> "stream" capability / option) the filter process needs to read
> *whole contents* at once, *before* writing anything.  Otherwise
> it can lead to deadlock.
>=20
> This is especially important in that it is different (!) from the
> current behavior of `clean` and `smudge` filters, which can
> stream their response because Git invokes them async.

I added this:
" Please note, that the filter
must not send any response before it received the content and the
final flush packet. "


>> +
>> +If the filter experiences an error during processing, then it can
>> +send the status "error" after the content was (partially or
>> +completely) sent. Depending on the `filter.<driver>.required` flag
>> +Git will interpret that as error but it will not stop or restart the
>> +filter process.
>> +------------------------
>> +packet:          git< status=3Dsuccess
>> +packet:          git< 0000
>> +packet:          git< HALF_WRITTEN_ERRONEOUS_CONTENT
>> +packet:          git< 0000
>> +packet:          git< status=3Derror
>> +packet:          git< 0000
>> +------------------------
>=20
> Good.  A question is if the filter process can send "status=3Dabort"
> after partial contents, or does it need to wait for the next command?

I added:
"expected to respond with an "abort" status at any point in
the protocol."


>> +
>> +After the filter has processed a blob it is expected to wait for
>> +the next "key=3Dvalue" list containing a command. Git will close
>> +the command pipe on exit. The filter is expected to detect EOF
>> +and exit gracefully on its own.
>=20
> Good to have it documented. =20
>=20
> Anyway, as it is Git command that spawns the filter driver process,
> assuming that the filter process doesn't daemonize itself, wouldn't
> the operating system reap it after its parent process, that is the
> git command it invoked, dies? So detecting EOF is good, but not
> strictly necessary for simple filter that do not need to free
> its resources, or can leave freeing resources to the operating
> system? But I may be wrong here.

The filter process runs independent of Git.


>> +
>> +
>> Interaction between checkin/checkout attributes
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>=20
>> diff --git a/contrib/long-running-filter/example.pl =
b/contrib/long-running-filter/example.pl
>> new file mode 100755
>> index 0000000..c13a631
>> --- /dev/null
>> +++ b/contrib/long-running-filter/example.pl
>=20
> To repeat myself, I think it would serve better as a separate patch.

OK


>> +        die "invalid packet size '$bytes_read' field";
>=20
> This would read "invalid packet size '000' field", for example.
> Perhaps the following would be (slightly) better:
>=20
>  +        die "invalid packet size field: '$bytes_read'";

OK


>> +    }
>> +    elsif ( $pkt_size > 4 ) {
>=20
> Isn't a packet of $pkt_size =3D=3D 4 a valid packet, a keep-alive
> one?  Or is it forbidden?

"Implementations SHOULD NOT send an empty pkt-line ("0004")."
Source: Documentation/technical/protocol-common.txt


>> +            die "invalid packet ($content_size expected; $bytes_read =
read)";
>=20
> This error message would read "invalid packet (12 expected; 10 read)";
> I think it would be better to rephrase it as
>=20
>  +            die "invalid packet ($content_size bytes expected; =
$bytes_read bytes read)";

OK


>> +        die "invalid packet size";
>=20
> I'm not sure if it is worth it (especially for the demo script),
> but perhaps we could show what this invalid size was?
>=20
>  +        die "invalid packet size value '$pkt_size'";

OK


>> +sub packet_txt_read {
>> +    my ( $res, $buf ) =3D packet_bin_read();
>> +    unless ( $buf =3D~ /\n$/ ) {
>=20
> Wouldn't
>=20
>  +    unless ( $buf =3D~ s/\n$// ) {
>=20
> or (less so)
>=20
>  +    unless ( $buf =3D~ s/\n$\z// ) {
>=20
> be more idiomatic (and not require use of 'substr')?  Remember,
> the s/// substitution quote-like operator returns number of
> substitutions in the scalar context.

OK.


>> +        die "A non-binary line SHOULD BE terminated by an LF.";
>=20
> This is SHOULD be, not MUST be, so perhaps 'warn' would be enough.
> Not that Git should send us such line.

Actually it MUST per protocol definition. I'll change it to MUST.


>> +    my ($packet) =3D @_;
>=20
> This is equivalent to
>=20
>  +    my $packet =3D shift;
>=20
> which, I think, is more common for single-parameter subroutines.
>=20
> Also, this is $data (or $buf), not $packet.

OK


> Perhaps some comment that main begins here?
>=20
>> +( packet_txt_read() eq ( 0, "git-filter-client" ) ) || die "bad =
initialize";
>> +( packet_txt_read() eq ( 0, "version=3D2" ) )         || die "bad =
version";
>> +( packet_bin_read() eq ( 1, "" ) )                  || die "bad =
version end";
>=20
> Actually, it is overly strict.  It should not fail if there
> are other "version=3D3", "version=3D4" etc. lines.

True, but I think for an example this is OK. I'll add a note
to the file header.


>> +
>> +while (1) {
>> +    my ($command)  =3D packet_txt_read() =3D~ /^command=3D([^=3D]+)$/;=

>> +    my ($pathname) =3D packet_txt_read() =3D~ /^pathname=3D([^=3D]+)$/=
;
>=20
> Do we require this order?  If it is, is that explained in the
> documentation?

Git sends that order right now but the filter should not rely
on that order.


>> +    packet_flush();    # empty list!
>=20
> This is less "empty list!", and more keeping "status=3Dsuccess" =
unchanged.

OK


OK means, I agree and I added your suggestion to v9.
Thanks a lot for your review and the comments!

Cheers,
Lars=
