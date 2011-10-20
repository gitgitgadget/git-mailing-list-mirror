From: Kyle Moffett <kyle@moffetthome.net>
Subject: Re: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Thu, 20 Oct 2011 00:32:55 -0400
Message-ID: <CAGZ=bq+y1Q1KKUwyBJmWMoAWn_+M+CBNVBh-UBtLttqN6_gjew@mail.gmail.com>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
 <20111019190114.GA4670@sigill.intra.peff.net> <20111019193834.GA14168@sigill.intra.peff.net>
 <20111020025149.GA31549@sigill.intra.peff.net> <CAGZ=bqK2oVPxW3mm-WHMd1+KSiPquympJyhRqLWr1F=G74p+BA@mail.gmail.com>
 <7vzkgw9tjw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 06:33:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGkJt-0006uC-Vq
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 06:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101Ab1JTEdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 00:33:25 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62689 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab1JTEdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 00:33:25 -0400
Received: by ywf7 with SMTP id 7so2410164ywf.19
        for <git@vger.kernel.org>; Wed, 19 Oct 2011 21:33:24 -0700 (PDT)
Received: by 10.68.32.2 with SMTP id e2mr17608584pbi.68.1319085196109; Wed, 19
 Oct 2011 21:33:16 -0700 (PDT)
Received: by 10.142.77.10 with HTTP; Wed, 19 Oct 2011 21:32:55 -0700 (PDT)
In-Reply-To: <7vzkgw9tjw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184004>

On Thu, Oct 20, 2011 at 00:27, Junio C Hamano <gitster@pobox.com> wrote:
> Kyle Moffett <kyle@moffetthome.net> writes:
>
>> Heh, there's one other practical downside I can think of...
>>
>> If you create a bunch of commits with the same 8-hex-character prefix
>> then suddenly the "git describe" logic for using the first 7 commit ID
>> characters gets a whole lot less useful.
>
> In the sense that you need to cut and paste a lot more characters, you are
> correct that it would make it less useful, but if you are talking about
> uniqueness, you are mistaken.
>
> The rule is not "using the first 7 hexdigits", but is "using as many
> hexdigits to make assure uniqueness, but use at least 7".

Well, yes, but if you generate some 10 commits with the same
7-character prefix, run "git describe", and then generate another
several with the same prefix... Chances are the previously-unique
output of "git describe" is no longer unique.

Also, even if you do use enough characters for it to be reliably
unique, it's not really an abbreviation if your commit description is
"v2.0.3-42-gdeadbeef04a69f", with that many characters you might as
well just paste the whole SHA1 sum.

With all that said, it is a very clever (and ugly) hack :-D.  Kudos!

Cheers,
Kyle Moffett

-- 
Curious about my work on the Debian powerpcspe port?
I'm keeping a blog here: http://pureperl.blogspot.com/
