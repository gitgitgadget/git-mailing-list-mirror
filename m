From: =?windows-1251?B?yu7t/Oru4iDF4uPl7ejp?= <kes@reg.ru>
Subject: git BUG
Date: Mon, 22 Oct 2012 20:28:20 +0400
Organization: =?windows-1251?B?0OXj6PHy8ODy7vAgxO7s5e3t+/UgyOy47Q==?=
Message-ID: <863549238.20121022202820@reg.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 18:28:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQKrl-0002ir-T9
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 18:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654Ab2JVQ2Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Oct 2012 12:28:25 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33169 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab2JVQ2Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2012 12:28:24 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so2366083wgb.1
        for <git@vger.kernel.org>; Mon, 22 Oct 2012 09:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reg.ru; s=google;
        h=date:from:x-mailer:organization:x-priority:message-id:to:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=jMniGOyY8rO8joLPUJTqwY2uyUb7KpNSYN/W1gUtp5w=;
        b=tysJ9yGp8ReHb0uiunPAMYlPc7xGf4vHX3E0p2tbrvHA4xdn5AMXVQeoMFDFdZh7hm
         6ReUd9FuyC4pPEyRkKb9m90YmWBeO6VnW7hpZKhSxTcvO3eoGN738rpuTx+kei8q09DB
         dcje9lxZrCZZT2EHHNjyH6kv34lhxpmZuKkj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:x-mailer:organization:x-priority:message-id:to:subject
         :mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=jMniGOyY8rO8joLPUJTqwY2uyUb7KpNSYN/W1gUtp5w=;
        b=bnSmQPDk1k1FRq/0IQSo8OytIlrDbRix+tfbIHYZ+Qm6vpq1ydLVcSelwfDedmS/8V
         VV+KHsipzvVBS8VPO2+5mNJWP4d+SNA9WSaMJPgEjlSJSE57dclWJ1R/NXe5nZJVaIvk
         Ar2KIHuWt+JhQaNQoYy9GsUeUFOwQrKq74x0R/aYwJdBLPVCcoPAUQaaVcoB9pIWx9Am
         kZDr/JeCCSTcWYepmiy19JIhfLmm70n3ovx59jRark61/xS4aOfRAJwA5NdKy8n5Qa4h
         WApz2kZk+RDQtP66BFuxELq8n/vo1wfcvew+L09ozV8Ne3UOLUbLLNwCEDTYFoGHXdzA
         T5TQ==
Received: by 10.180.84.202 with SMTP id b10mr22485409wiz.13.1350923302740;
        Mon, 22 Oct 2012 09:28:22 -0700 (PDT)
Received: from KES-PC ([77.93.52.13])
        by mx.google.com with ESMTPS id j8sm51808330wiy.9.2012.10.22.09.28.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Oct 2012 09:28:21 -0700 (PDT)
X-Mailer: The Bat! (v4.0.24) Professional
X-Priority: 3 (Normal)
X-Gm-Message-State: ALoCoQlpJayBZwaqGo9hnb3nQQjRr5ZJ2mdX0dDxuzsNLcG8dtcJb7xZseoaUIxki/Ea2QB0hZj+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208196>

Hi, git

I have get git bug while merging branches.

the farm has branch one year old. say b1
I have develop some feature in this year so I start new branch
  git checkout master
  git checkout -b b2

I get task to develop feature b1. b1 require changes in b2
  git checkout b1
  git merge b2
  git checkout --theirs
  git commit

after some time I need new code from master
  git merge master

after this merge I notice that some code, that was developed in b2, is
disappeared despite on it was merged into b1

so I start to merge it again:
  git merge b2

No results. So I decide to do some testing. I go to b2
  git checkout b2

make changes into file on b2:
diff --git a/lib/SRS/Domain.pm b/lib/SRS/Domain.pm
index 8fa1b1a..23a9429 100644
--- a/lib/SRS/Domain.pm
+++ b/lib/SRS/Domain.pm
@@ -2804,6 +2804,7 @@ sub can_renew_state {
 sub zone {
     my ( $self ) =3D  @_;

+
     load_class 'SRS::Comm::Zone::Domain';

     return

I have add one empty line to subroutine that have developed in b2.
  git commit
  git checkout b1
  git merge b2

and I get conflict:
+++ b/lib/SRS/Domain.pm
@@@ -2830,24 -2801,20 +2830,29 @@@ sub can_renew_state

  =3Dcut

 -sub zone {
 -    my ( $self ) =3D  @_;
 +sub can_cancel_transin {
 +    my $self =3D shift;

++<<<<<<< HEAD
 +    return if $self->{freeze_date};
 +    return unless $self->{create_method} eq 'trans' && $self->{state}=
 eq 'N';
++=3D=3D=3D=3D=3D=3D=3D
+
+     load_class 'SRS::Comm::Zone::Domain';
++>>>>>>> yandex_mail_new_api

 -    return
 -        SRS::Comm::Zone::Domain->new(
 -            dname   =3D> $self->{dname},
 -            service =3D> $self,
 -        );
 +    my ( $pos_id ) =3D dbh_rw->selectrow_array(
 +        'SELECT bi.pos_id FROM billitems bi JOIN bills b ON b.bill_id=
 =3D bi.bill_id WHERE service_id =3D
 +        undef,
 +        $self->{service_id}, $self->{user_id}
 +    );
 +
 +    return $pos_id;
  }

 -=3Dback
 +=3Ditem cancel_transin
 +
 +=D4-=F6=E8=FF =EE=F2=EC=E5=ED=FB =EF=E5=F0=E5=ED=EE=F1=E0

  =3Dcut


As you can see conflict at 'can_cancel_transin' subroutine
but I do changes in 'zone' subroutine


Please help to resolve that CONFLICT and return code from b2 to be
alive again in b1.

And, if you can, please explain why this occur

--=20
 =D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC,
 =CA=EE=ED=FC=EA=EE=E2 =C5=E2=E3=E5=ED=E8=E9
 =CF=F0=EE=E3=F0=E0=EC=EC=E8=F1=F2
 =D0=E5=E3=E8=F1=F2=F0=E0=F2=EE=F0 =E4=EE=EC=E5=ED=ED=FB=F5 =E8=EC=E5=ED=
 REG.RU
 =D2=E5=EB=E5=F4=EE=ED: +38 (097) 7654-676
 www.reg.ru
 ___________________
 Sincerely yours,
 Konkov Eugen
 Developer
 Accredited domain Registrar REG.RU, LLC.
 Phone: +38 (097) 7654-676
 www.reg.ru/en/

mailto:kes@reg.ru
