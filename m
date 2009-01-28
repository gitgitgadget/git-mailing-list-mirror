From: PJ Hyett <pjhyett@gmail.com>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Tue, 27 Jan 2009 17:57:49 -0800
Message-ID: <bab6a2ab0901271757i4602774ahef1d881b7ed58097@mail.gmail.com>
References: <bab6a2ab0901271504j73dce7afjf8436c3c7c83b770@mail.gmail.com>
	 <bab6a2ab0901271510y1e3e6912t82ff16e0f912d4b6@mail.gmail.com>
	 <alpine.DEB.1.00.0901280034310.3586@pacific.mpi-cbg.de>
	 <20090127233939.GD1321@spearce.org>
	 <7v1vuo1f6d.fsf@gitster.siamese.dyndns.org>
	 <bab6a2ab0901271634x7201130bx4a565bd8bea6967b@mail.gmail.com>
	 <7vvds0z1c1.fsf@gitster.siamese.dyndns.org>
	 <7vk58gz04l.fsf@gitster.siamese.dyndns.org>
	 <7vfxj4yzjj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 02:59:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRzi1-0008Q8-MZ
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 02:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbZA1B5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 20:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbZA1B5w
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 20:57:52 -0500
Received: from rv-out-0506.google.com ([209.85.198.229]:15197 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbZA1B5v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 20:57:51 -0500
Received: by rv-out-0506.google.com with SMTP id k40so6705180rvb.1
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 17:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rbtHoN0MXuDPskun7WpV9FJoLIPm48kU/1o+nX8WNE0=;
        b=Nfz7L4YyCqQVRywymWO6Qs8ByE6ZNMwJ/CP6NSoWjK5wAQgz3oZVrspBY15VC1QnbT
         2BRbrtpHggSGtGBU7sQKVuDPvOSRQ1RGIDBaHN/xSrPqxcGXtpiA/JgjZduBmjaPNh+L
         FtFTSn2nFFxjtsn0HlmxmKHmOa3vKxb06rdtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CRvO4e5Rz+ZX6c3EYUMvE6ZoFchWA0s2uAyJI1ul8K4KzUB7sXKrXLPGuqVBXw6qvT
         kZSdeoESKbhrCkNBnuv6zDPqbx4fYrJ8HHhkC8X4/BAU22WO4ufV++GCVZWzarG0eyPI
         ezq/JbPEXe2SWcVZ7Z271/8TL4PSEagCAA3Qk=
Received: by 10.141.201.1 with SMTP id d1mr1462295rvq.56.1233107869208; Tue, 
	27 Jan 2009 17:57:49 -0800 (PST)
In-Reply-To: <7vfxj4yzjj.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107450>

On Tue, Jan 27, 2009 at 5:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> The extra "we also have these" advertisement happened as a result of this
>> discussion:
>>
>>     http://thread.gmane.org/gmane.comp.version-control.git/95072/focus=95256
>>
>> I think I know what is going on.
>>
>> Consider this sequence of events.
>>
>>  (0) Alice creates a project and pushes to public.
>>
>>     alice$ cd $HOME/existing-tarball-extract
>>     alice$ git init
>>     alice$ git add .
>>     alice$ git push /pub/alice.git master
>>
>>
>>  (1) Bob forks it.
>>
>>     bob$ git clone --bare --reference /pub/alice.git /pub/bob.git
>
> I need another /pub/alice.git here, I think, but I hope I got the point
> across to people who are capable of helping us to resolve this issue.
>
>>
>>  (2) Bob clones his.
>>
>>     bob$ cd $HOME && git clone /pub/bob.git bob
>>
>>  (3) Alice works more and pushes
>>
>>     alice$ edit foo
>>     alice$ git add foo
>>     alice$ git commit -a -m 'more'
>>     alice$ git push /pub/alice.git master
>>
>>  (4) Bob works more and tries to push to his.
>>
>>     bob$ cd $HOME/bob
>>     bob$ edit bar
>>     bob$ git add bar
>>     bob$ git commit -a -m 'yet more'
>>     bob$ git push /pub/bob.git master
>>
>> Now, the new server advertises the objects reachable from alice's branch
>> tips as usable cut-off points for pack-objects bob will run when sending.
>>
>> And new builtin-send-pack.c has new code that feeds "extra" refs as
>>
>>       ^SHA1\n
>>
>> to the pack-objects process.
>>
>> The latest commit Alice created and pushed into her repository is one such
>> commit.
>>
>> But the problem is that Bob does *NOT* have it.  His "push" will run pack
>> object telling it that objects reachable from Alice's top commit do not
>> have to be sent, which was the whole point of doing this new "we also have
>> these" advertisement, but instead of ignoring that unknown commit,
>> pack-objects would say "Huh?  I do not even know that commit" and dies.
>>
>> This can and should be solved by client updates, as 1.6.1 server can work
>> with older client just fine.
>
> Here is a *wrong* fix that should work most of the time.  It will
> certainly appear to fix the issue in the above reproduction recipe.
> You may want to ask your users to try this to see if it makes their
> symptom disappear.
>
> When we receive ".have" advertisement, this wrong fix checks if that
> object is available locally, and it ignores it otherwise.
>
> This won't be acceptable as the official fix.  We should be doing the
> full connectivity check; in other words, not just "do we have it", but "do
> we have it *and* is it reachable from any of our own refs".
>
>  connect.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git c/connect.c w/connect.c
> index 2f23ab3..8026850 100644
> --- c/connect.c
> +++ w/connect.c
> @@ -43,6 +43,9 @@ int check_ref_type(const struct ref *ref, int flags)
>
>  static void add_extra_have(struct extra_have_objects *extra, unsigned char *sha1)
>  {
> +       if (!has_sha1_file(sha1))
> +               return;
> +
>        ALLOC_GROW(extra->array, extra->nr + 1, extra->alloc);
>        hashcpy(&(extra->array[extra->nr][0]), sha1);
>        extra->nr++;
>

Thank you for your detailed response. To answer your previous
question, all of the bug reports have been made by users running
1.6.1.

My concern is that we obviously have no control over what version of
Git our 50k+ users are running, and we will be perpetually stuck
running 1.5 on the servers to account for this issue.

Is there any possibility to have the server code in an upcoming
release account for clients running 1.6.1?

-PJ
