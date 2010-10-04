From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv6 01/16] test-lib: make test_expect_code a test command
Date: Sun, 3 Oct 2010 23:06:23 -0500
Message-ID: <20101004040623.GC24884@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-2-git-send-email-newren@gmail.com>
 <7vfwwmdbgl.fsf@alter.siamese.dyndns.org>
 <AANLkTinVvmJMEDhPcxa_CiOL2_RsYBdo-JywXi2gKeYp@mail.gmail.com>
 <20101004035007.GB24884@burratino>
 <AANLkTi=7mrROAhFxNmF_cmU2OKKNuhsdTUVpHT+4Jg-Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 06:09:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2cN2-0004Tj-AS
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 06:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005Ab0JDEJj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 00:09:39 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:64647 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667Ab0JDEJj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 00:09:39 -0400
Received: by qyk10 with SMTP id 10so560443qyk.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 21:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=TvPTcaxx6mEYfdVj0LmhYX4laPtIhm6YJ5VjzdBuOQw=;
        b=LqanwwtjyeAU7bpvabeTml8xYUfWserq8DXzZgnsaKtC6tUvqUt3mVE2G6DumSpWEc
         5MFVBietB2DjTF6e4ZwFUWex4lm4YJbDo0OnDbkRkf2ixwui+tE4BzJZ2iJEfszjMNjU
         jp6e3YlXPVQ6bEhPhyWclEIDNRTf0KcHFAnHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=QlkISreBnzr64naRZHTCzz+vJ3Tt6g1jyTeU7n/disPdARWMqEU7oVt5Qgu4MJn2+t
         YAyV3qYoYSIf00HhTB/b0J/C98AmpJe28MoxOn8a43SfGAG1XcHtRMi2tRhkcwostCNm
         QvfJfyVsIx3lLaxHxNvMIGQUGNTeFSBc1XaNM=
Received: by 10.229.239.129 with SMTP id kw1mr6542725qcb.90.1286165378262;
        Sun, 03 Oct 2010 21:09:38 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id r38sm4933873qcs.2.2010.10.03.21.09.36
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 21:09:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=7mrROAhFxNmF_cmU2OKKNuhsdTUVpHT+4Jg-Y@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157972>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Oct 4, 2010 at 03:50, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:

>> I suspect the best thing would be to export TEST_DIRECTORY
>> instead of including it inline in the script.
>
> We could do that, but then you couldn't cd to the trash directory and
> manually run the test without exporting the path to TEST_DIRECTORY
> again.

Okay, then how about:

	: ${TEST_DIRECTORY=3D$(cd ../.. && pwd)}
	. "$TEST_DIRECTORY"/test-lib.sh

i.e., accepting TEST_DIRECTORY from the environment if and only
if it is available?
