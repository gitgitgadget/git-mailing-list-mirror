From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH v2 3/3] git-p4: Add test case for complex branch import
Date: Mon, 23 Jan 2012 14:01:14 +0000
Message-ID: <CAOpHH-W1LY3Q50otrcNJTYWN67k_pCZHEOkgbKy7kPgfUbGeQw@mail.gmail.com>
References: <1327105292-30092-1-git-send-email-vitor.hda@gmail.com>
 <1327105292-30092-4-git-send-email-vitor.hda@gmail.com> <7vehutd59p.fsf@alter.siamese.dyndns.org>
 <4F1A98A3.2090607@diamand.org> <20120121171130.GA6235@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Jan 23 15:01:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpKT1-00031X-SG
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 15:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431Ab2AWOBr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jan 2012 09:01:47 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:46507 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752194Ab2AWOBq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 09:01:46 -0500
Received: by lahc1 with SMTP id c1so1621665lah.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 06:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9gzHbpk82A9jYZzSpdFFLcBoMGFpVafjDlIrY0VNZZA=;
        b=NjPoU+cs+SVKVAUNSkqBCgpzS+0NKuQ6LQlQOwRKdqlPpunKSo3ztz222K7KkhzxBO
         QlktQmlwzbhKCzgtFlNtC0HYFJT9qqhhrbOuxG5fMg0VP2LuDZXzFMTIRjTucaCGv+BU
         Mei3w82tpvlUtFZDddx+L0dCZRESP+iGJ7PMs=
Received: by 10.112.23.230 with SMTP id p6mr2133750lbf.103.1327327305237; Mon,
 23 Jan 2012 06:01:45 -0800 (PST)
Received: by 10.152.105.179 with HTTP; Mon, 23 Jan 2012 06:01:14 -0800 (PST)
In-Reply-To: <20120121171130.GA6235@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188991>

On Sat, Jan 21, 2012 at 5:11 PM, Pete Wyckoff <pw@padd.com> wrote:
> luke@diamand.org wrote on Sat, 21 Jan 2012 10:51 +0000:
>> However, one thing I noticed in reading through is that it will
>> break if you end up importing a P4 branch that has spaces (or other
>> shell chars) in its name. A quick test confirms this.
>>
>> - the code doesn't handle the names properly
>> - git and p4 have different ideas about valid branch names
>>
>> But before rejecting Vitor's changes because of that it would be
>> worth considering whether we care (much). My own opinion is that if
>> you have developers who are daft enough to put spaces or dollars in
>> their branch names then their project is already doomed anyway....
>>
>> Perhaps it would be enough just to issue a warning ("your project is
>> doomed; start working on your CV") and skip such branch names rather
>> than falling over with inexplicable error messages.
>
> This doesn't seem like a big deal. =A0The read_pipe and
> read_pipe_lines calls shoud be list-ified. =A0That gets rid
> of the problem with shell interactions.
>
> For git branch name reserved characters, a little function
> to replace the bogus characters with "_" would avoid needing
> to go work on the resume. =A0Anything in bad_ref_char() and
> check_refname_component(). =A0I agree this doesn't have to be
> perfect.
>
> This could be a new patch unrelated to Vitor's series, which
> verifies branch names anywhere a new commit is made.

I would also prefer to include that fix on a separate patch series that
would include the test case Luke already prepared. In my opinion,
updating read_pipe and read_pipe_lines is out of scope for the current
patch series.

BTW, and on an unrelated topic, are any test cases failing on your side=
?

Thanks,
Vitor
