Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 247551F453
	for <e@80x24.org>; Tue, 18 Sep 2018 15:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbeIRVAz (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 17:00:55 -0400
Received: from ober.noekeon.org ([91.134.133.203]:54254 "EHLO ober.noekeon.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729733AbeIRVAz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 17:00:55 -0400
X-Greylist: delayed 560 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Sep 2018 17:00:52 EDT
Received: from Joans-MacBook-Pro.local (unknown [131.254.252.243])
        by ober.noekeon.org (Postfix) with ESMTPSA id EFC6D2220A;
        Tue, 18 Sep 2018 17:18:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=noekeon.org; s=mail;
        t=1537283909; bh=U0csN/w9GM8EjGcOSGTM9ZrG2x3JFQT8aSwNfFdDmxU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Pg5eyHD0Ue5msaU7jwIj7AcaLDXY6E6gmDvs6nIz/N+ssUQW4OUq8RRJUV0fxnlff
         afTmWW43ACq+GpXUvZiMx8aICRXoBPwKcp+Owqpcc7JfwKv4//fBJ7zhprZVP0Rc2T
         iragqxYJSQQM9SmDABI4awGnHf4EHtOl+LBV5fZk=
Subject: Re: Hash algorithm analysis
To:     Dan Shumow <danshu@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net>
 <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net>
 <20180724190136.GA5@0f3cdde9c159>
 <CA+55aFwSe9BF8e0hLk9pp3FVD5LaVY5GRdsV3fbNtgzekJadyA@mail.gmail.com>
 <xmqqzhygwd5o.fsf@gitster-ct.c.googlers.com>
 <20180724221008.GI18502@genre.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1807301058560.10478@tvgsbejvaqbjf.bet>
 <MWHPR21MB01738A46E37527E45E950937C42F0@MWHPR21MB0173.namprd21.prod.outlook.com>
From:   Joan Daemen <jda@noekeon.org>
Openpgp: preference=signencrypt
Autocrypt: addr=jda@noekeon.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <64c1fc82-8830-bd62-7cc6-ef76ad06f6d5@noekeon.org>
Date:   Tue, 18 Sep 2018 17:18:28 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB01738A46E37527E45E950937C42F0@MWHPR21MB0173.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,

when going over my todo list I was confronted with the mail of Dan Shumow=
 on the successor of SHA-1 for git. I know the decision was made and it i=
s not my intention to change it, but please see below some comments on Da=
n's arguments.

In short, I argue below that SHA256 has no serious advantages when compar=
ed to KangarooTwelve. In that light, the fact that SHA2 was designed behi=
nd closed doors (like SHA-1 was) should be enough reason to skip it entir=
ely in an undertaking that takes open-source seriously.

Kind regards,

Joan

PS: In my comments below I use "we" as I discussed them with the members =
of the Keccak team being Gilles Van Assche, Micha=C3=ABl Peeters, Guido B=
ertoni, Ronny Van Keer and Seth Hoffert, and we agree on all of them.

On 30/07/2018 22:01, Dan Shumow wrote:
> Hello all.   Johannes, thanks for adding me to this discussion.
>
> So, as one of the coauthors of the SHA-1 collision detection code, I ju=
st wanted to chime in and say I'm glad to see the move to a longer hash f=
unction.  Though, as a cryptographer, I have a few thoughts on the matter=
 that I thought I would share.
>
> I think that moving to SHA256 is a fine change, and I support it.
>
> I'm not anywhere near the expert in this that Joan Daeman is.=20

Note that the correct spelling is "Daemen". But anyway, it is not a matte=
r of being expert, but a matter of taking the arguments at face value.=20

> I am someone who has worked in this space more or less peripherally.  H=
owever, I agree with Adam Langley that basically all of the finalists for=
 a hash function replacement are about the same for the security needs of=
 Git.  I think that, for this community, other software engineering consi=
derations should be more important to the selection process.

We are also with Adam on the engineering considerations. We see the paral=
lelism that K12 can exploit adaptively (unlike SHA256) as an example of s=
uch a consideration.

> I think Joan's survey of cryptanalysis papers and the numbers that he g=
ives are interesting, and I had never seen the comparison laid out like t=
hat.  So, I think that there is a good argument to be made that SHA3 has =
had more cryptanalysis than SHA2.  Though, Joan, are the papers that you =
surveyed only focused on SHA2?  I'm curious if you think that the design/=
construction of SHA2, as it can be seen as an iteration of MD5/SHA1, mean=
s that the cryptanalysis papers on those constructions can be considered =
to apply to SHA2? =20

This argument works both ways, i.e., the knowledge and experience of the =
symmetric cryptography community in general has also contributed to our c=
hoices in Keccak and in K12 (including the experience gained by Rijndael/=
AES). But in the end, the only objective metric we have for comparing pub=
lic scrutiny is the amount of cryptanalysis (and analysis) published, and=
 there Keccak simply scores better.

> Again, I'm not an expert in this, but I do know that Marc Steven's tech=
niques for constructing collisions also provided some small cryptanalytic=
 improvements against the SHA2 family as well.  I also think that while t=
he paper survey is a good way to look over all of this, the more time in =
the position of high profile visibility that SHA2 has can give us some co=
nfidence as well.

High profile visibility to implementers does not mean more cryptanalysis,=
 since users and implementers are usually not cryptanalysts. Actually, on=
e of the reasons that SHA2 attracted much less cryptanalysis than you wou=
ld expect due to its age is that during the SHA3 competition all cryptana=
lysts pointed their arrows to SHA3 candidates.

> Also something worth pointing out is that the connection SHA2 has to SH=
A1 means that if Marc Steven's cryptanalysis of MD5/SHA-1 were ever succe=
ssfully applied to SHA2, the SHA1 collision detection approach could be a=
pplied there as well, thus providing a drop in replacement in that situat=
ion.  That said, we don't know that there is not a similar way of address=
ing issues with the SHA3/Sponge design.  It's just that because we haven'=
t seen any weaknesses of this sort in similar designs, we just don't know=
 what a similar approach would be there yet.  I don't want to put too muc=
h stock in this argument, it's just saying "Well, we already know how SHA=
2 is likely to break, and we've had fixes for similar things in the past.=
"  This is pragmatic but not inspiring or confidence building.
>
> So, I also want to state my biases in favor of SHA2 as an employee of M=
icrosoft.  Microsoft, being a corporation headquartered in a America, wit=
h the US Gov't as a major customer definitely prefers to defer to the US =
Gov't NIST standardization process.  And from that perspective SHA2 or SH=
A3 would be good choices.  I, personally, think that the NIST process is =
the best we have.  It is relatively transparent, and NIST employs a fair =
number of very competent cryptographers.  Also, I am encouraged by the wi=
despread international participation that the NIST competitions and selec=
tion processes attract.

Of course, NIST has done (and is still doing) a great job at organizing p=
ublic competitions, where all submissions have to include a design ration=
ale and where the final selection is based on extensive openly published =
cryptanalysis and comparisons done by the cryptographic community. This i=
s obviously AES and SHA3. However, NIST also put forward NSA designs as s=
tandards, without design rationale or public cryptanalysis whatsoever, an=
d in some cases even with built-in backdoors
(EC-DRBG as Dan probably remembers). Examples of this are DES, SHA(0), SH=
A-1 and, yes, SHA2. The former we would call open-source philosophy and
the latter closed-source.

> As such, and reflecting this bias, in the internal discussions that Joh=
annes alluded to, SHA2 and SHA3 were the primary suggestions.  There was =
a slight preference for SHA2 because SHA3 is not exposed through the wind=
ows cryptographic APIs (though Git does not use those, so this is a nonis=
sue for this discussion.)

We find it cynical to bring up a Microsoft-internal argument that is actu=
ally not relevant to Git.

> I also wanted to thank Johannes for keeping the cryptographers that he =
discussed this with anonymous.  After all, cryptographers are known for b=
eing private.  And I wanted to say that Johannes did, in fact, accurately=
 represent our internal discussions on the matter.

Our experience is that in the cryptographic community there are many outs=
poken individuals that fearlessly ventilate their opinions (sometimes eve=
n controversial ones).

> I also wanted to comment on the discussion of the "internal state havin=
g the same size as the output."  Linus referred to this several times.  T=
his is known as narrow-pipe vs wide-pipe in the hash function design lite=
rature.  Linus is correct that wide-pipe designs are more in favor curren=
tly, and IIRC, all of the serious SHA3 candidates employed this.  That sa=
id, it did seem that in the discussion this was being equated with "lengt=
h extension attacks."  And that connection is just not accurate.  Length =
extension attacks are primarily a motivation of the HMAC liked nested has=
hing design for MACs, because of a potential forgery attack.  Again, this=
 doesn't really matter because the decision has been made despite this di=
scussion.  I just wanted to set the record straight about this, as to avo=
id doing the right thing for the wrong reason (T.S. Elliot's "greatest tr=
eason.")

Indeed, vulnerability to length extension attacks and size of the interna=
l state (chaining value in compression function based designs, or capacit=
y in sponge) are two different things. Still, we would like to make a few=
 points here.

1) There were SHA3 submissions that were narrow-pipe, i.e., finalist Blak=
e is narrow-pipe.

2) SHA2 and its predecessors are vulnerable to length extension, SHA3 (or=
 any of the SHA3 finalists) isn't. Length extension is a problem when usi=
ng the hash function for MAC computation but this can be fixed by putting=
 a construction on top of it. That construction is HMAC, that comes with =
some fixed overhead (up to a factor 4 for short messages).

3) The relatively large state in the sponge construction increases the ge=
neric strength against attacks when the input contains redundancy or
has a certain form. For instance, if the input is restricted to be text i=
n ASCII (such as source code), then the collision-resistance grows
higher than the nominal 2^{c/2}. Such an effect does not exist with narro=
w-pipe Merkle-Damg=C3=A5rd. (This may be what Linus had intuitively in mi=
nd.)

> One other thing that I wanted to throw out there for the future is that=
 in the crypto community there is currently a very large push to post qua=
ntum cryptography.  Whether the threat of quantum computers is real or im=
agined this is a hot area of research, with a NIST competition to select =
post quantum asymmetric cryptographic algorithms.  That is not directly o=
f concern to the selection of a hash function.  However, if we take this =
threat as legitimate, quantum computers reduce the strength of symmetric =
crypto, both encryption and hash functions, by 1/2. =20

This is not what the experts say. In [1] a quantum algorithm is given tha=
t reduces the effort to generate a hash collision to 2^{n/3} (instead of =
2^{n/2} classically). So according to [1] the strength reduction is 2/3 r=
ather than 1/2. Moreover, in [2], Dan Bernstein takes a more detailed loo=
k at the actual cost of that algorithm and argues that the quantum algori=
thm of [1] performs worse than classical ones and that there is no securi=
ty reduction at all for collision-resistance.

[1] Gilles Brassard, Peter H=C3=B8yer, Alain Tapp, Quantum cryptanalysis =
of hash and claw-free functions, in LATIN'98 proceedings (1998), 163=E2=80=
=93169.

[2] Daniel J. Bernstein, Cost analysis of hash collisions: Will quantum c=
omputers make SHARCS obsolete? Workshop Record of SHARCS'09.

> So, if this is the direction that the crypto community ultimately goes =
in, 512bit hashes will be seen as standard over the next decade or so.  I=
 don't think that this should be involved in this discussion, presently. =
  I'm just saying that not unlike the time when SHA1 was selected, I thin=
k that the replacement of a 256bit hash is on the horizon as well.
>
> Thanks,
> Dan Shumow
>


