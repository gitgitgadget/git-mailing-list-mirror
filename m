From: David Caldwell <david@porkrind.org>
Subject: Re: [PATCH] stash: Add --clean option to stash and remove all untracked
 files
Date: Mon, 20 Jun 2011 18:36:42 -0700
Message-ID: <4DFFF5AA.4030401@porkrind.org>
References: <1308612986-26593-1-git-send-email-david@porkrind.org> <20110621003852.GB2050@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 21 03:36:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYptj-0007EO-1k
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 03:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123Ab1FUBgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 21:36:52 -0400
Received: from kill.porkrind.org ([68.68.97.104]:51433 "EHLO
	david.xen.prgmr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932085Ab1FUBgv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 21:36:51 -0400
Received: from porkrind.org (cpe-98-151-185-99.socal.res.rr.com [98.151.185.99])
	by david.xen.prgmr.com (Postfix) with ESMTPS id 744242BD48;
	Mon, 20 Jun 2011 18:36:47 -0700 (PDT)
Authentication-Results: david.xen.prgmr.com; dkim=pass
	(1536-bit key; insecure key) header.i=@porkrind.org
	header.b=oWT7nUV6; dkim-adsp=pass
Received-SPF: pass (porkrind.org: authenticated connection) receiver=porkrind.org; client-ip=127.0.0.1; helo=black.porkrind.org; envelope-from=david@porkrind.org; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from black.porkrind.org (localhost [127.0.0.1])
	(authenticated bits=0)
	by porkrind.org (8.14.4/8.14.4/Debian-2) with ESMTP id p5L1ahws030968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NOT);
	Mon, 20 Jun 2011 18:36:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=porkrind.org;
	s=apoptygma; t=1308620205;
	bh=gSewQbNWGjs9+yAD36YNEV0PeYw24gFb3lKeW8xGVCU=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=oWT7nUV6wuaWAzyTuKtjll49aUul2THkMnN5Ww75ilZDjB3i2gl/h8kZl5poW8meT
	 yCb2/VO1t2ELWBaaCFVaqKAiVFjs6y9xvc/UQaWoljQYtLtcsImkxKmORI3rJGOktH
	 XmC14sNClBOACAjRlv1LXqqbg5SzB8GmYhazjA0xIJbkMRH3hsQl45J9iPfdJrFwxs
	 UcNDhBndEUdQOKshK22363igP5pwa1zuYD47qiSaHLTpYirHI2FWqxD9RJr
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10 ThunderBrowse/3.3.5
In-Reply-To: <20110621003852.GB2050@sigill.intra.peff.net>
X-Enigmail-Version: 1.1.1
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAQAAAD9CzEMAAAACXBIWXMAAAsTAAALEwEAmpwY
 AAAABGdBTUEAALGOfPtRkwAAACBjSFJNAAB6JQAAgIMAAPn/AACA6QAAdTAAAOpgAAA6mAAAF2+S
 X8VGAAABiklEQVR42rRYSZIDIQwzLv7/ZXLoEAzeBKG7ag4DRhZeBKQ0Qr5imLWCrKwn0HImc1Mx
 aAvmmc/cuAT7RMYws6v/gHeb0p4/y5792GJJlLZWOPgsdV5NaRes4Xe4632sLljD7wKv1Ta74H/h
 MxecN1Rc2TatYcP7zb+6WFfN/zMSHg1Ymuxjrzd+DuLw6Nlekggt1hvr7KK9tRIX85jjM6GTYhfv
 nzXH3jBdYc4koueBs66M+Xv9O9n5ML4urWssjGeMY3if3bzGSvk30BQ46OOaxJjLCpzPJAzXrOrD
 z5VFh58TIiwESIiCHNxxwPTy97qDei8YdpVdyYEv6EQcK8n+iTyE/Cn1eoe7HwN+F56oErVSGtJY
 Q1sR2ehaUHfjvJuv0tL7qAzEbBmfF2IHrVi8zp9N0pZtQZZHOXp/sLW4+hqKvm3iccaPwP3XgnKX
 n8/YtVeOsnenRG7VCBFlZ5fe3LOyANCVdGAIwDs7tTXGF4hIk15/iAfSgv2UkNFItSszOG3Ha7r0
 GQBerhBkHOAzmQAAAABJRU5ErkJggg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
	T_DKIM_INVALID,UNPARSEABLE_RELAY autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on kill.porkrind.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176118>

On 6/20/11 5:38 PM, Jeff King wrote:
> On Mon, Jun 20, 2011 at 04:36:26PM -0700, David Caldwell wrote:
> 
>> The --clean option acts like the normal "git stash save" but also adds all
>> untracked files in the working directory to the stash and then calls "git
>> clean --force --quiet" to restore the working directory to a pristine
>> state.
> 
> Hmm. I think I would call this something like "--untracked", as to me
> the main function is saving those files, not cleaning them afterwards
> (the fact that they are cleaned is really just making the untracked-file
> handling in line with what we do for tracked files; we put the changes
> in the stash and remove them from the working tree).

I see your point but I thought "--clean" was pretty descriptive of how
the working dir ended up afterward. Maybe "git stash --everything" (or
"--all")?

>> "git stash" alone is not enough in this case--it leaves untracked files
>> lying around (configure and automake droppings, for instance) that might
>> mess up a release process that expects everything to be very clean.
> 
> For that workflow, do you actually want the files saved and restored
> via "stash pop"? That is, aren't those untracked files just useless
> cruft that could be regenerated, and you would be just as happy to do:
> 
>   $ git tag release-1.0
>   $ git stash
>   $ git clean
>   $ make release
>   $ git stash pop
>
> and have a pristine state after your pop?

Yes, in that case you are right. My example was poor. I'm more worried
about junk that might actually affect the release but isn't
auto-generated. I'm usually too wary to run "git clean" because of the
random files I have sitting around--todo lists, random patches, new
files I haven't added but are sitting around possibly affecting tests,
things like that. I want them back at some point, but I want the
directory very clean when doing the release just to make sure I have
everything properly committed (so I could, for example, detect the new
source file that I forgot to add and commit).

> Also, wouldn't you want to "git clean" after your "make release" but
> before your "git stash pop" in case the build creates cruft that is not
> overwritten by your stash pop?

Yes, you'd definitely want the git clean before the git stash pop. I
forgot that step.

> Please put your comments on the patch (i.e., anything not destined to go
> into the commit message) below the "---" marker; that helps "git am"
> know which part is which.

Whoops. That was a copy and paste error. Took multiple tries to get git
send-email to work ;-).

>>   * I used 'find . -name ".git" -prune -o -print' to get a list of all the
>>     files in the working directory. That assumes ".git" is the name
>>     of the repo--is that assumption valid?
> 
> Generally yes, but somebody could do something tricky with GIT_DIR. You
> should be using "git ls-files -o" instead.

Ah, thanks--I didn't know about that command! I was considering using
"git status --porcelain", but ls-files looks exactly like what I want.

> For that matter, what should this do with gitignored files, like
> generated object files?
> 
>>   * Also, that find command does not respect .gitignore. Should it?
> 
> I'm not sure of the answer to this. I think it would depend on your
> workflow and your project (i.e., is your build system fragile enough
> that you need to get rid of ignored build products between builds, or is
> it OK to leave them, which is more efficient). I would think respecting
> ignore would be a sane default, but I don't know if it should be
> configurable, or have an extra command line option to stash everything.
> 
> If you do want to respect .gitignore, then you can add
> "--exclude-standard" to the "ls-files" command I mentioned above.

The more I think about it the more I think you're right that it should
respect .gitignore on the default case and have another option to be
really thorough (even if my build system isn't always fragile, it's
sometimes nice to be overly cautious just for my own paranoid peace of
mind).

Perhaps --clean (or --untracked) respects .gitignore and --all just flat
out does everything?

>> @@ -86,7 +87,7 @@ create_stash () {
>>  			git read-tree --index-output="$TMPindex" -m $i_tree &&
>>  			GIT_INDEX_FILE="$TMPindex" &&
>>  			export GIT_INDEX_FILE &&
>> -			git diff --name-only -z HEAD | git update-index -z --add --remove --stdin &&
>> +			(git diff --name-only -z HEAD; test -n "$clean" && find . -name ".git" -prune -o -print0) | git update-index -z --add --remove --stdin &&
>>  			git write-tree &&
>>  			rm -f "$TMPindex"
>>  		) ) ||
> 
> When you apply this stash, what does the resulting index look like? Do
> the untracked files remain properly untracked? That might be a good
> thing to double check in the test script.

They do in indeed, but you're right, that would be a good automated test
to add.

Thanks, I greatly appreciate the help.

-David
