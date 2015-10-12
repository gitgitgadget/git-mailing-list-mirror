From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] pull --rebase: reinstate helpful message on abort
Date: Mon, 12 Oct 2015 11:16:15 +0200
Organization: gmx
Message-ID: <d2116a492e14f07c8969798ce21c78a2@dscho.org>
References: <cover.1444336120.git.johannes.schindelin@gmx.de>
 <47e66f159e8929879f22504a180330e3fa020ee9.1444336120.git.johannes.schindelin@gmx.de>
 <xmqqbnc7q489.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Brendan Forster <shiftkey@github.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 11:16:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlZDV-00084G-5I
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 11:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbbJLJQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 05:16:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:53787 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858AbbJLJQS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 05:16:18 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LvVUR-1akN6y3ecd-010gSf; Mon, 12 Oct 2015 11:16:15
 +0200
In-Reply-To: <xmqqbnc7q489.fsf@gitster.mtv.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:sAnGy7oFxJBLtbc3Efi+gHq4ZoeJKjblKhR1kQTUbcc7unbgMtT
 bkCF5uOFCom7wuV7raA7l4fIfBfcwVCd/Ky9erj+/Sgx/sCYOvVNkSucE7Vy6cxNtno4PUk
 Spz3TFfUoDnNlZg8ItjclX3HQa9efe8l95SUjcRaDgA3K45qDB/TUXGwh23z7vpqKMZvgOx
 H1WOMn+yODM8A85UFWYvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JRvIKJ57hGo=:XoAUQSo8+sykYzFDfULanC
 WvvF24PhBF8IpLTz3P3i7GfERg0TYAdVJDLeb0DWfaVGnUbw0Yk7WqKZO0XDGPyX67gc1RLxp
 geHZSh6uuX+A5zM87/boCUM+/tBk7Spx0wmJ+Q2Df21PMCqVaxxNUw3iOrEmv7fWnk33HBues
 4elTcYjnHm6x4YwKy2ldWfq9qvgFDohtLNTERBk+uCcTQYwrNRDTWtoI56icDH+76MnOprDFI
 CSVadeTvM67mpuo28ExMZYPm2521cE8qpUvKYtS9e+kfBpXOiomFelyMv91xz35PnHwXLUJMl
 ExYNZte//hIkG1DBns0CcvVHqYgnFeffSkBy0JG2vNh2JUMRl4JbLw4z+CuJIOUAPpb2jGtww
 UG9v8YWZeLYZ2jfA/QFoHrLxua2MW11wYCQUpEY9clEHGJxR+TbMNBmPy2lS5VQuO0pbSOsmp
 Nxoev9shcUA7mxnQvTVhDvHiuZ2aLraMiZ4s6PtaMbAx0KdDkXcMipFuYuVwpQsnyTx0n+eZ6
 KUPkVVZk+NxkleOnWu40YEjXGkNDateJC1tp3/Z4kuYU34g0mhPIyeEX/HFO3tvyDZO88Y4vk
 5hzC9GFO86iEm/oiJm5gfSqze0g+0h/XlIeTUVGRCb6EPJHpJy5r/25UaZcmeVemKMzHmFHwJ
 PjWDbCkMtWWAf0vFt2pV17lHekG9BXP5m5tWwwOxUStOV2yu7l8v+LLh3Tkb/9GkNvG00D4DI
 +y3dJsS6I++mI4fBaSCSO6Lg53B1JJbsS+S1YRv21Scvfp+Iflaqu9YGz5E2diK+aXoACg2u 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279368>

Hi Junio,

On 2015-10-09 20:36, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> When calling `git pull --rebase`, things can go wrong. In such a case,
>> we want to tell the user about the most common ways out of this fix:
>> ...
>>  builtin/am.c | 1 +
>>  1 file changed, 1 insertion(+)
> 
> It is strange to see a patch to am that does not talk anything about
> it, though.  And looking at the codepath, the issue does not have
> much to do with "pull --rebase".  It doesn't even have much to do
> with "rebase".  This is purely about "am -3" fallback codepath.

I made it a habit of describing the big picture in commit messages, including the original motivation for the patch. Naturally, it is purely an implementation detail that the bug displayed by `git pull --rebase` is fixed by modifying `am.c`.

> Because fall-back-threeway wants to react to an error (i.e. calls
> merge_recursive_generic() and wants to use its return value), but
> merge_recursive_generic() can die, it fails to do so.  It would not
> even run rerere(), for example.

Precisely, So the symptom triggering the bug fix was seemingly unrelated to the patch, hence the need for the comprehensive commit message.

Since our tastes seem to differ a bit, maybe we can have the best of both worlds by appending the following paragraph to the commit message?

-- snipsnap --
This patch actually fixes a deeper-seated bug where the non-gentle death of the recursive merge would prevent not only the message from being shown but *any* code to run after the failed merge, including rerere.
