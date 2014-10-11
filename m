From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH v2 1/2] mergetool: don't require a work tree for --tool-help
Date: Sat, 11 Oct 2014 09:35:51 +0100
Message-ID: <3D01E1E7-627C-427F-9E99-4B2271447B0D@hashpling.org>
References: <1412931104-74648-1-git-send-email-davvid@gmail.com> <FCAAE5E4-E220-4B45-A6A1-B2AFB79F9069@hashpling.org> <20141011082954.GA79450@gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Charles Bailey <cbailey32@bloomberg.net>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 11 10:36:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xcs9l-00073r-0P
	for gcvg-git-2@plane.gmane.org; Sat, 11 Oct 2014 10:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbaJKIgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2014 04:36:00 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:42541 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbaJKIf6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Oct 2014 04:35:58 -0400
Received: from hashpling.plus.com ([212.159.69.125]:55575 helo=[192.168.76.37])
	by host02.zombieandprude.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1Xcs9W-0000bw-QG; Sat, 11 Oct 2014 09:35:50 +0100
X-Mailer: iPhone Mail (12A405)
In-Reply-To: <20141011082954.GA79450@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org




> On 11 Oct 2014, at 09:29, David Aguilar <davvid@gmail.com> wrote:
> 
> Thanks for the heads-up.
> 
> I tested mergetool and it seems fine but indeed there's an
> `if test -e "$GIT_DIR/MERGE_RR"` in there that is surely not
> working as intended.
> 
> One solution would be to move the work done in the test -z "$NONGIT_OK"
> block in git-sh-setup into a function e.g. git_dir_init () so
> that we can defer the GIT_DIR initialization until after
> require_work_tree has been called.

I believe I had a very similar idea but the vast number of things that would potentially be affected by changing git-sh-setup.sh made me put things on hold in case I had any other ideas.

I haven't so I think this is probably the best approach.