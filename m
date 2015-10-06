From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Oct 2015, #01; Mon, 5)
Date: Tue, 6 Oct 2015 06:45:49 +0200
Message-ID: <561351FD.9020102@web.de>
References: <xmqqwpv0x6op.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	remi.galan-alfonso@ensimag.grenoble-inp.fr
X-From: git-owner@vger.kernel.org Tue Oct 06 06:46:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjK8g-0002Qh-PJ
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 06:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbbJFEqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 00:46:05 -0400
Received: from mout.web.de ([212.227.15.14]:55419 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009AbbJFEqE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 00:46:04 -0400
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MIBu2-1Zm5IE0RJ8-003ylx; Tue, 06 Oct 2015 06:45:52
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <xmqqwpv0x6op.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:nf1cegb6RyQ7AbWqUJYAzP2wu9BaBnqVTVq5cAlpZF02kQUbEOJ
 nosaqAaC/68d06E5FV4C4PYb/f0L1/CMQGzKr/KWMvagn+3/4/8hV9VCjxXdFYMXv4b9y90
 KE9hI52vDTbWfTCSJLOuhOnyk4Hai4pctEPVpxd1mgM8+rKFmc5wrELSyS6nP7ugVKW1BsZ
 k95LQWb1G/ZzJ8B8KdQng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RYL6bx7K9XM=:wY5EROJwuGjxNIHeXdXRxt
 y+D2Ua25Lj0RBdbW3kpMYetOVJ6ttYIBmZ6AamT3oBxzDKev27irqWITuI2NB5XR+LTZ+3Wcf
 GQmdl+1jBDZixIIK4tBKCXvkhGQ2qnJvmlXORYqoc61XLRxt3u3WVZWwWT9ZCrkREbwTPky3s
 JeZzmQRgo78liEAszDcrI7/gcfQ3C3py6rPuwXgXc7pRB7WNehw37w3IOpiSf+9AzQYAJFuda
 F4x/YP4EB4QvW/lezIs9V3X+ZfTeWSh3ydt2g6aEfrUiduKQg9HSd6zxrS4rT2+jt6/S3PLwO
 0C9mPD6nf/0RIE2zpBIgQZfYI/8LCc91RnEYq33INeTqJi8JQsSMXIgTrvIncOiBiDuPzbjm9
 tLbjDccchbpNIOgc4F1H22YrbU/3xxFQ22GjJ6zx42OU7z26+ksRFBAgD0YvWVH127G3D2bBI
 R2//daBxdgEwtbKEb/WvZF2IqOm9UfmWLp5agrvGI3CHxBqci7xbOhKjwlclvyqv3JF1TpR1I
 Lip5nWJcOV3f0a60EtpIm2tPJFXIaN/vlWGa/k9aWoeX3G0Qj90KrjQm/EPJIy4cd65/YXzKQ
 cuXQaURiESy8kQF9GQZ2PBK2neftMAPHDgWHHFAtxtpe9MG9JlxTAyktuq9lk2x0kd1CcMhvI
 jRIF8aov7WHqutKu/gZaQFBUk9JLfbiNcRT81knHX2c5ryayS1YwAiwwLXWjoThHHCa/5a13z
 f0BMlD+9Sw6P1rLdn7CKYs6MKigVPzcssyMJGRHgG//j25/PXuGWNrkB/eO7xbg9yJsW8khv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279118>

On 06.10.15 00:59, Junio C Hamano wrote:
> * gr/rebase-i-drop-warn (2015-10-02) 2 commits
>  - rebase-i: loosen over-eager check_bad_cmd check
>  - rebase-i: explicitly accept tab as separator in commands
> 
>  "git rebase -i" had a minor regression recently, which stopped
>  considering a line that begins with an indented '#' in its insn
>  sheet not a comment, which is now fixed.
> 
>  Will merge to 'next'.
This is breaking using a non-gnu sed, which doesn't handle "\t"...
The solution is to replace "\t" with a literal TAB.



diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 3da3ba3..3de0b1d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1232,7 +1232,7 @@ test_expect_success 'tabs and spaces are accepted in the todolist' '
 	write_script add-indent.sh <<-\EOF &&
 	(
 		# Turn single spaces into space/tab mix
-		sed "1s/ /\t/g; 2s/ /  /g; 3s/ / \t/g" "$1"
+		sed "1s/ /	/g; 2s/ /  /g; 3s/ / 	/g" "$1"
 		printf "\n\t# comment\n #more\n\t # comment\n"
 	) >$1.new
 	mv "$1.new" "$1"
