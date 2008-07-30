From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Support copy and rename detection in fast-export.
Date: Wed, 30 Jul 2008 11:35:35 -0700
Message-ID: <7vvdyn5ifc.fsf@gitster.siamese.dyndns.org>
References: <200807211216.01694.angavrilov@gmail.com>
 <200807262249.18005.angavrilov@gmail.com>
 <20080726202103.GA15769@spearce.org>
 <200807270052.55370.angavrilov@gmail.com>
 <7v7ib4hdpu.fsf@gitster.siamese.dyndns.org>
 <bb6f213e0807300210r205846b4qffa9fc71d4aa6533@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Alexander Gavrilov" <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 20:37:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOGXU-0000vO-Lb
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 20:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbYG3Sfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 14:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbYG3Sfo
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 14:35:44 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45153 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbYG3Sfn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 14:35:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 77D3F43A52;
	Wed, 30 Jul 2008 14:35:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2931F43A51; Wed, 30 Jul 2008 14:35:36 -0400 (EDT)
In-Reply-To: <bb6f213e0807300210r205846b4qffa9fc71d4aa6533@mail.gmail.com>
 (Alexander Gavrilov's message of "Wed, 30 Jul 2008 13:10:07 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 50B6A654-5E66-11DD-8622-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90829>

"Alexander Gavrilov" <angavrilov@gmail.com> writes:

>> If you see a copied or renamed entry, you emit "this old path to that old
>> path" first, and then say that same path got modified.  It appears from my
>> quick glance of fast-import that touching the same path more than once in
>> a same commit like this sequence does would work fine (it will involve two
>> calls to tree_content_set() for the same path but that is not something it
>> has to forbid, and the function doesn't).
>
> I'm sorry, but I don't quite understand what are you suggesting by
> this paragraph.

Sorry for the unmarked remark --- this was not a question, suggestion nor
complaint, but just a plain observation.  I should have ended the
paragraph with "--- I think it's all good." to avoid confusion.

>>> +export GIT_AUTHOR_NAME='A U Thor'
>>> +export GIT_COMMITTER_NAME='C O Mitter'
>>> +
>>> +test_expect_success 'setup copies' '
>>> +
>>> +     git config --unset i18n.commitencoding &&
>>
>> These are somewhat unusual.  Was there any reason for these exports and
>> config?
>>
>
> t9301-fast-export.sh earlier changes these parameters to test
> automatic conversion to utf8.

Yeah, I noticed that while looking at wider context, after I sent the
message you are responding to.

Anyway, thanks for the patch.  Applied and pushed out.
