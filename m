From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Sun, 8 Feb 2009 12:52:37 +0100
Message-ID: <2c6b72b30902080352y2ada3f36t85a05dcacb77a5bb@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk>
	 <20090206191511.GD19494@coredump.intra.peff.net>
	 <2c6b72b30902061410l64c98c33g19b97f656d347c83@mail.gmail.com>
	 <20090207071056.GB14856@coredump.intra.peff.net>
	 <7vprhuzoxm.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.10.0902070050490.8086@asgard.lang.hm>
	 <2c6b72b30902080247n31e5c532m31006fcb07ca95da@mail.gmail.com>
	 <2c6b72b30902080255w6ccac5e9vcd961a9ab93dcdf3@mail.gmail.com>
	 <20090208110628.GB14359@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 08 12:54:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW8Eh-0002Pb-7y
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 12:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbZBHLwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 06:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbZBHLwk
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 06:52:40 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:41264 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbZBHLwj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 06:52:39 -0500
Received: by fxm13 with SMTP id 13so2094251fxm.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 03:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=27vGNmj6CV4z6i5/FJJZ82YH9tCsovTDMGh4JynpOq4=;
        b=lfTVMnMZWl5FsoBqvOvYx/0t4nMEHVrSsqQcaCMD8OTTy/q13K1K44Ap2HwZnji8t/
         26E6DekLS+GK4gX7iV6N2vmKQ391hNLFwXjuALQL7LaM7DRHtsqSvlQIR9sTXD1lPReT
         6soDe/CJhF53qYg1OOydELakDYqik868aymQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=hOaoyokJMJrS4bEklaB/TQwyca+Ywhy2D9LwldBcjtWlHxKa3WfF/T68AKEJRf+lrA
         ocaueC9S4x8FirW2ClfR3MnBS5c1yYwwab9nKV67Bep2UqymWePTmhI3jnjFhOzZRIf2
         AI+We/cB8L6RLJZIZEoJOS36PUg8AOF2VaouQ=
Received: by 10.181.219.15 with SMTP id w15mr15874bkq.90.1234093957690; Sun, 
	08 Feb 2009 03:52:37 -0800 (PST)
In-Reply-To: <20090208110628.GB14359@coredump.intra.peff.net>
X-Google-Sender-Auth: b899eb759323ea17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108965>

On Sun, Feb 8, 2009 at 12:06, Jeff King <peff@peff.net> wrote:
> On Sun, Feb 08, 2009 at 11:55:55AM +0100, Jonas Fonseca wrote:
>
>> On Sun, Feb 8, 2009 at 11:47, Jonas Fonseca <fonseca@diku.dk> wrote:
>> > One problem it does not yet handle is the
>> > cut'n'paste within the same file where the deleted line ends up in a
>> > different hunk.
>>
>> Hmm, this is trivially fixed by passing -M to git blame so maybe that
>> should just be the default for tig.
>
> Yes, I think that is worth doing. It might also be nice to show the
> original filename in the blame output (perhaps optionally if it is
> different than the original). However, you might want to look at how
> "git gui blame" does it. It actually shows _two_ entries for each line:
> the origin of the content, and the commit that moved the content into
> place.
>
> I don't know if that is worth doing in tig or not; I think you generally
> want to assume a much more constrained screen size (though I have to
> admit that I generally maximize my terminal to use "tig blame" anyway --
> 80x25 just doesn't cut it).

I wouldn't mind not showing the date and sha1 columns. The sha1 column
is mustly there to give a clue about what lines are from the same
commit, but that could be done better using the ideas from git-gui.

Will look into it when I get some more time ...

-- 
Jonas Fonseca
