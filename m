From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Problems with new location of submodule's GIT_DIR
Date: Fri, 17 Aug 2012 13:38:18 -0400
Message-ID: <CABURp0q84skieqmdd5qSBrdXFTOjNm5asQgVrB42UttrEOEpDw@mail.gmail.com>
References: <1345217299.7952.83.camel@athena.dnet> <502E73E4.9080601@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniel Milde <daniel@milde.cz>, git <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Aug 17 19:38:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2QVR-0004cv-P6
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 19:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755722Ab2HQRil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 13:38:41 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:40590 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab2HQRij (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 13:38:39 -0400
Received: by qcro28 with SMTP id o28so3277507qcr.19
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 10:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lMh3s63UVTUpAsao0EIZ2amZtzm6Vb9Fn7NA390Ow8M=;
        b=LQBh6UpNtb+2wdIYH2hKHXDUpwzKg26hT2G3MDirGkwMYzMsBDSDQrDgQWILCClzJ9
         nL7+pHB0VTfFPychpnBPqpcnMtwzkXVumQ+YjuGdU6sEtYTYT4sX0VrUJHXemCwF1717
         DwU6TI4bNeXFAMBa629zTE6n7usZjzmvBbYaDOxdQoL6HHDVGQQdnKpbgm+hvUPqllvi
         pZ4mtugyEhBO1JOdKT72Xsz/5C/fs01OAeJECz4342sLTras1s9YiFjOIkiw2xNWZGlJ
         FnTEedHAv+NtVTgPjdZ9gxMeq6u/IZjdeLRXi9yqe6kLDfYJNJ6YBYvMA4W14csfp5k9
         Z/6Q==
Received: by 10.229.137.12 with SMTP id u12mr4319050qct.28.1345225118980; Fri,
 17 Aug 2012 10:38:38 -0700 (PDT)
Received: by 10.229.52.77 with HTTP; Fri, 17 Aug 2012 10:38:18 -0700 (PDT)
In-Reply-To: <502E73E4.9080601@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203631>

On Fri, Aug 17, 2012 at 12:40 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 17.08.2012 17:28, schrieb Daniel Milde:
>> Hi all,
>> I have encountered some difficulties with the new location of the
>> metainformation directory (GIT_DIR) of submodules.
>>
>> The change of location happened in 1.7.8:
>>
>>  * When populating a new submodule directory with "git submodule init",
>>    the $GIT_DIR metainformation directory for submodules is created
>> inside
>>    $GIT_DIR/modules/<name>/ directory of the superproject and referenced
>>    via the gitfile mechanism. This is to make it possible to switch
>>    between commits in the superproject that has and does not have the
>>    submodule in the tree without re-cloning.
>>
>> Which problems it causes:

>> 3) Submodules became dependent on superproject. This is quite bad if you
>> are using submodules a lot (e.g. versioning the whole working space),
>> because you cannot move or copy them out of the superproject now.
>
> Okay, that use case is new to me. What is the intention when you move a
> submodule out of the work tree? Couldn't you just as easily clone the
> upstream repo again at the new place?

Not all git projects have upstreams.  Maybe this is a local project only.

In any case, cloning the upstream anew does not preserve local history.

Maybe the future 'git submodule mv' can be smart about moving a
submodule to a new location outside of a superproject.  Maybe it can
do so explicitly with the --export switch.

Phil
