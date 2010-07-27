From: Tong Sun <suntong@cpan.org>
Subject: Recommended work flow with git to send in patches
Date: Tue, 27 Jul 2010 11:31:24 -0400
Message-ID: <AANLkTiksAOpFG3vGVGcbeZ0NcpQ5FbDjnZ7yDxUsAY_r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 27 17:31:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odm7v-0000Pj-IG
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 17:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649Ab0G0PbZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 11:31:25 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:34384 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514Ab0G0PbY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 11:31:24 -0400
Received: by pxi14 with SMTP id 14so494107pxi.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 08:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=OCbv0VwpBKA1xvkn5jHTfJSGgu4Uk4IflM5BhAzH+Vk=;
        b=QJEY4PmxkdUKlx7RJJSLu62vJUbrTv1wYC4w/87Kr1HeS6BIvvSDfoBCB2YkWWO3zy
         Dj0rE0MQOgd31HkyVammnrceeXaOaHxzNWjnPdy0V4P3x1bOgMkbFqP3DrQfC+EXhhdG
         rF9LAOzRdOrfzTT35pQySeyZgQwCKdsmclZZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=kxZbwcbiEwlMOp78dD3GABLgq3LUOpVCTJK9aAb6ibNhKrFtmgy47QS/rmwuFFduh+
         cA78I/gl8+hUtF3y2VggKtP8xh237y0+7DMVGT0AJy8I2zT8ze/BjFO5h7ji6wmPsAwd
         BCh5WYfl7q8wQv3BRbI2gsexolxjOLa/p3rPo=
Received: by 10.114.103.14 with SMTP id a14mr13753309wac.31.1280244684278; 
	Tue, 27 Jul 2010 08:31:24 -0700 (PDT)
Received: by 10.114.130.11 with HTTP; Tue, 27 Jul 2010 08:31:24 -0700 (PDT)
X-Google-Sender-Auth: IIlzSwgrcbDbE3v3C9Wv2N7ssr0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151948>

Hi,

Compressing my "life long story" into a single question -- what's the
recommended work flow to work with git and send in patches, when
upstream might be slow in respond, and require squashing relevant
patches into one?

You can use my following message as a start point, and please answer
my last question, which I've been asking twice (in different ways)
with no answer.

Please CC me when replying.

Thanks

---------- Forwarded message ----------
=46rom: Tong Sun <suntong@cpan.org>
Date: Sun, Jun 6, 2010 at 8:56 PM
Subject: Working with git and sending in patches
To: grml-devel@ml.grml.org


Hi,

Just trying to put all jigsaw puzzle together here. Please correct me
if I'm wrong.

=46irst of all, philosophy for version control with git:

=2E While developing, small/independent commits are good thing, so that
it's easy to decouple different changes.

=2E But when integrating something in a main branch, commits should con=
tain all
logical/related changes.

Steps (using grml-debootstrap as an example):

- do initial git pull into grml-debootstrap

=A0 git pull git://git.grml.org/grml-debootstrap master

- Go into grml-debootstrap and start a new branch

=A0 git checkout -b t/my-working-branch

- work on the code, commit, hack, commit, hack, commit -- commit often
& commit small

- when AOK and need to integrate patches into main branch, squash all
patches into one

=A0 git rebase -i origin/master

- send in patches via email (to grml-devel@ml.grml.org)

=A0 git format-patch origin
=A0 git send-email --to grml-devel@ml.grml.org ...

Please correct me if anything above is wrong.

Now, question, having done above, if I start to work some logically
unrelated patches, what steps should I take? (I don't want 'git
rebase' to pick up patches that I've already sent in).
