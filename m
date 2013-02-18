From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Recursive submodule confusing output (bug?)
Date: Mon, 18 Feb 2013 20:35:35 +0100
Message-ID: <51228287.1070202@web.de>
References: <CAFwrLX6EWPureNoyjuMVy13kgwyAgDBcd1Eoet7hQ1CB9OhLxQ@mail.gmail.com> <CAFwrLX5nPvySfA05CLgdfoNt-pzQbCq0o+LtGJxZyVwP0EyHcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Will Entriken <fulldecent@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 20:36:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7WVR-0005bV-1L
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 20:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756899Ab3BRTfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 14:35:38 -0500
Received: from mout.web.de ([212.227.17.11]:53671 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755025Ab3BRTfh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 14:35:37 -0500
Received: from [192.168.178.41] ([91.3.158.27]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0MGA7n-1U40Gm43cN-00Evb3; Mon, 18 Feb 2013 20:35:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <CAFwrLX5nPvySfA05CLgdfoNt-pzQbCq0o+LtGJxZyVwP0EyHcg@mail.gmail.com>
X-Enigmail-Version: 1.5
X-Provags-ID: V02:K0:2ygUx/RlbzUxZIsLAWjwDckyurX1ij7f9qmNfBIIyce
 v5JAb4mQ+bqKMn7gj+u8uhMPBFqdt2mPB7FnBEzUtqhk6+rXMT
 uMtQjiq+jd0hHWKeCdol+VZ7n+VTzW6A6ZGHZUJHSgAfbhAyp6
 27MS1ZtUtuebgKBn+WdK1ffHOho7M5J/uLeupeAVXTkaF1beC0
 ob5mAw5B5MWmPahZWFS2g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216501>

Am 18.02.2013 16:58, schrieb Will Entriken:
> I am running:
> 
>     git submodule update --recursive
> 
> And get the output:
> 
>     Submodule path 'Submodules/evernote-ios-sdk': checked out
> '391ca643c5b1cd02e9fa869a6b0760436ea452ed'
>     Submodule path 'Submodules/facebook-ios-sdk': checked out
> 'ada467f754febd4f2871d15943e9be16b323f114'
>     Submodule path 'Submodules/objectiveflickr': checked out
> 'f474a78c807b5fa0c887bf8efaead5be1da637ec'
>     Submodule path 'Submodules/sskeychain': checked out
> '8252a69cdfea562223d4dc2e2ccaf01b752d2cc6'
> 
> This is a little confusing to me, would this be more appropriate?
> 
>     Submodule path 'Submodules/ShareKit/Submodules/evernote-ios-sdk':
> checked out '391ca643c5b1cd02e9fa869a6b0760436ea452ed'
>     Submodule path 'Submodules/ShareKit/Submodules/facebook-ios-sdk':
> checked out 'ada467f754febd4f2871d15943e9be16b323f114'
>     Submodule path 'Submodules/ShareKit/Submodules/objectiveflickr':
> checked out 'f474a78c807b5fa0c887bf8efaead5be1da637ec'
>     Submodule path 'Submodules/ShareKit/Submodules/sskeychain':
> checked out '8252a69cdfea562223d4dc2e2ccaf01b752d2cc6'

Yes. (I assume from the output that you have a submodule named
"Submodules/ShareKit/" in the superproject which itself contains
those four submodules inside another "Submodules" directory)

> Please let me know if this is something I may fix.

Sure, go ahead! (I just checked, cmd_update() is the only function
in git-submodule.sh without prefix handling; see cmd_foreach() for
an example of how to do that). And - if you're not already familiar
with it - you'll find a detailed description on how to prepare your
fix in "Documentation/SubmittingPatches".
