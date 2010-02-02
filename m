From: Arun Raghavan <ford_prefect@gentoo.org>
Subject: Re: [PATCH 0/2] upload-pack: pre- and post- hooks
Date: Tue, 2 Feb 2010 11:22:18 +0530
Message-ID: <6f8b45101002012152y76bccb65n78235fce170675ef@mail.gmail.com>
References: <6f8b45101001150414r2661001ep10819b601953c05b@mail.gmail.com> 
	<1265013127-12589-1-git-send-email-ford_prefect@gentoo.org> 
	<20100201152010.GC8916@spearce.org> <alpine.LFD.2.00.1002011116320.1681@xanadu.home> 
	<20100201163618.GB9394@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 06:52:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcBgq-0001O9-9M
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 06:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942Ab0BBFwj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2010 00:52:39 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:21449 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab0BBFwi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2010 00:52:38 -0500
Received: by qw-out-2122.google.com with SMTP id 3so59466qwe.37
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 21:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=RuNcfJOMLiXf7X2aW74pCTIwZlqNojdXCvgN15rLfmg=;
        b=Uo0W76h1MfauyVC7VE/lMW6CaavOdPmCLxQwvHnEkFu8YGyS1kY079Is3UyN3daqsB
         2w2HXio5lIjBqK+zpntj6WAKjzhEqpDPmsAM6X1IvpUozMxumDzCrsIAdKd5uK5pC7xL
         7lyM7cNpvG4DX6gn4PCXwb7PTTAGmYgwkAE+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=tSZuZCuN8ifnUrBQWo1xOoxZK3hOdy31kneeMigrN/zur5GD7glPf7QsWfo9e7DlpF
         uAUvD1Q/YT1ioIp9oR8f/M1+FMgQ6LR/CS2OTPnUELRmArA1wjmYkGJBdQrXLsSdlhzu
         m4kCpBM/oYvmUZz2aPIsNDbUYhvbILaQyu4DU=
Received: by 10.229.3.202 with SMTP id 10mr2058281qco.103.1265089958123; Mon, 
	01 Feb 2010 21:52:38 -0800 (PST)
In-Reply-To: <20100201163618.GB9394@spearce.org>
X-Google-Sender-Auth: bd4a9689f7fdc105
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138683>

On 1 February 2010 22:06, Shawn O. Pearce <spearce@spearce.org> wrote:
> Nicolas Pitre <nico@fluxnic.net> wrote:
>> On Mon, 1 Feb 2010, Shawn O. Pearce wrote:
>> I think such hooks could be allowed only if triggered explicitly by =
the
>> upload-pack caller, such as git-daemon. =A0That's probably the only
>> scenario where a useful use case can be justified for them anyway.
>>
>> And of course, to avoid any security problems, the actual hooks must=
 not
>> be provided by the repository owner but provided externally, like fr=
om
>> git-daemon, via some upload-pack command line arguments. =A0This way=
 the
>> hooks are really controlled by the system administrator managing
>> git-daemon and not by any random git repository owner.
>>
>> That should be good enough for all the use cases those hooks were
>> originally designed for.
>
> Oooh, I like that.
>
> If the paths to the hooks are passed in on the command line of
> git-upload-pack, and git-daemon takes those options and passes
> them through, you're right, we probably get everything we need.
>
> Gitosis can still use the hooks if it wants, since it controls
> the call of git-upload-pack.

I can add the uid check before running the hook as well. Is that good
enough, or would you guys like me to start from scratch with the
command-line argument approach?

Cheers,
--=20
Arun Raghavan
http://arunraghavan.net/
(Ford_Prefect | Gentoo) & (arunsr | GNOME)
