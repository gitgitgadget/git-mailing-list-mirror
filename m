From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: Regression and failure to clone/fetch with new code Re: git-svn performance
Date: Thu, 30 Oct 2014 02:35:04 +0000
Message-ID: <1414636504.45506.YahooMailBasic@web172304.mail.ir2.yahoo.com>
References: <20141030002801.GB31920@dcvr.yhbt.net>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 03:35:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xjfa5-0007ON-60
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 03:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746AbaJ3CfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2014 22:35:08 -0400
Received: from nm2.bullet.mail.ir2.yahoo.com ([212.82.96.43]:43748 "EHLO
	nm2.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751541AbaJ3CfH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 22:35:07 -0400
Received: from [212.82.98.124] by nm2.bullet.mail.ir2.yahoo.com with NNFMP; 30 Oct 2014 02:35:05 -0000
Received: from [212.82.98.104] by tm17.bullet.mail.ir2.yahoo.com with NNFMP; 30 Oct 2014 02:35:05 -0000
Received: from [127.0.0.1] by omp1041.mail.ir2.yahoo.com with NNFMP; 30 Oct 2014 02:35:05 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 228027.14306.bm@omp1041.mail.ir2.yahoo.com
Received: (qmail 4143 invoked by uid 60001); 30 Oct 2014 02:35:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1414636505; bh=oAhbRKovICYdDttp1BQyqHVH6zMXrfjAOFhkrv2Nd5w=; h=Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=fpwG+fKF8WBNQw6SKCNkkUtwmweUI4sAn3VG+ODlfgMM8AVxDAjXLFz1KtpfTAvcny/2qxKDfWC9vxe31VyvcID4M+pZBUIqV8znKYjX7OJxhnqvLPTqA0r0FwuKd3/1hFLKAR8kpEkUdHxw+cvOBoMZzUhGdwWfBWFnozFngvY=
X-YMail-OSG: PVazmKkVM1lEW6UE3wFbVIMDD92YSsOKd7VJkjDY.EFlCc7
 pUiLxypq2S_X4zsiAnLYFu7R2elimjzjPXHbdZcdbCrxuTcTBMdWMZgDzYo7
 _v9QIIfGYOlBC9wf4npOnYDbzSno8lZg8qE7MJ6EikeVokZrTsdQlDX4QxOt
 ObvbKtkif1A8sw4XPB4SmFf97waWHpe.KCriyutcs6WaZ.RiKtu.Ac4JNsl1
 9RyrhnrDcXyxJd_eWcultXH7AC32_.5G4xsGNB5pSXDcI2aspJ1aIIiVhpTv
 r5Zs0ObAOk5.8B2YCFSz58QMMc.K17e1OhMj5AB.5XwknlHLV9jSphokk9xa
 Sbv3R7cbyOAmWSrI_WU61XQGMpBJgw6uL6hEeaOgd1gHi6UgTf5xVH93d0i3
 ZEtgVTCHcI.yNz_9FV4bqVir7_QcDUxtGXNQIyNTgl_Oxx.UMLhXb7WxjnyC
 ft6rt5t05dIvCRyc1UVp4gyz3JQ47K92I8i1rEBmb4fIlS6Fg2XzrcL9BAsk
 SjmFS1.5_0sskMEctsxXzMpPK9XdRAx4KUomiDrIZ7dWFbN.LogPSv._nmug
 KPJAXv9QuR8koIrZrUQ_jd7Tan3nkL.k4fh_TzioQLWOwEnqobkBuQWUR4Yb
 xUqXfbHBWkzinF5zqVsSDnWkVa6GY.gMyzfYR9m2uOiineIqrMg--
Received: from [86.30.137.134] by web172304.mail.ir2.yahoo.com via HTTP; Thu, 30 Oct 2014 02:35:04 GMT
X-Rocket-MIMEInfo: 002.001,SGVyZSBpcyB0aGUgZGF0YSBkdW1wZXIgaW5mbyAuIEkgdHJpZWQgdGhlIGR1bXBlciBjb2RlIG9uIHRoZSBSIHJlcG8NCmFzIHdlbGwsIGFuZCBzYXcgdGhhdCBhZ2FpbnN0IHRoZSB2aXJ0dWFsIGJveCByZXBvLCB0aGVyZSBpcyBvbmUgDQpjdXJpb3VzIGRpZmZlcmVuY2UgLSAkc2VsZi0.e2xhc3RfcmV2fSBpcyBhIHN0cmluZyByYXRoZXIgdGhhbiBhIG51bWJlci4NCkkgdHJpZWQgaGFja2luZyBhcm91bmQgZG9pbmcgIiR4ICs9IDA7IiB0byBjb2VyY2UgbGFzdF9yZXYNCnRvIGEgbnVtYmVyIGF0IHZhcmkBMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/810 YahooMailWebService/0.8.203.733
In-Reply-To: <20141030002801.GB31920@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is the data dumper info . I tried the dumper code on the R repo
as well, and saw that against the virtual box repo, there is one 
curious difference - $self->{last_rev} is a string rather than a number.
I tried hacking around doing "$x += 0;" to coerce last_rev
to a number at various places but didn't get very far. There seems to be some caching
code in RA->get_dir so presumably that's why the same code run
on one repo gives it as string while on another gives it a number. Hope
you can figure where the coersion to string happened.

--------
$ git svn fetch --all
Index mismatch: d6c75bc195b1daad647322e2cc025bd31265c6b9 != 3927d05f6ab037fcf2b4d964c9633efade037d1b
rereading a65b5fc0077c2fa80a344833b65ac19ff4ae88b6
	M	src/VBox/Main/HostImpl.cpp
$VAR1 = [
          bless( {
                   'map_root' => '.git/svn/refs/remotes/origin/trunk/.rev_map',
                   '-use_svm_props' => undef,
                   'ra_uuid' => 'cfe28804-0f27-0410-a406-dd0f0b0b656f',
                   'pushurl' => undef,
                   '-follow_parent' => 1,
                   '-no_metadata' => undef,
                   '-rewrite_uuid' => undef,
                   'repo_id' => 'svn',
                   '-rewrite_root' => undef,
                   'index' => '.git/svn/refs/remotes/origin/trunk/index',
                   'dir' => '.git/svn/refs/remotes/origin/trunk',
                   'ref_id' => 'refs/remotes/origin/trunk',
                   'url' => 'http://www.virtualbox.org/svn/vbox',
                   'last_rev' => '28923',
                   'last_commit' => 'a65b5fc0077c2fa80a344833b65ac19ff4ae88b6',
                   '_path' => 'trunk',
                   'config' => '.git/svn/config',
                   'logged_rev_props' => {
                                           'log' => 'Main/Host: fix lock order issues in several methods
',
                                           'date' => '2010-04-30T09:08:17.252108Z',
                                           'author' => 'vboxsync'
                                         }
                 }, 'Git::SVN' ),
          'trunk',
          '28923',
          'trunk',
          28924,
          '/branches/VBox-3.0:58652'
        ];
Incorrect parameters given: Could not convert '%ld' into a number at /usr/share/perl5/vendor_perl/Git/SVN.pm line 1713.

------

--------------------------------------------
On Thu, 30/10/14, Eric Wong <normalperson@yhbt.net> wrote:
 
> I was skimming and missed the part about Debian
 packages :)


I only asked because you mentioned using Debian :-).
The other 'Eric Wong' maintains/maintained a few chinese-related
debian packages, from some years ago.

I know of two "Ken Sharp", one of ghostscript and another of wine,
and two "David Turner", one of freetype and another of FSF's legal matters.
