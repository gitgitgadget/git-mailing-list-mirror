From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 2/2] Quoting paths in tests
Date: Wed, 17 Oct 2007 22:03:10 +0200
Message-ID: <85sl49ecg1.fsf@lola.goethe.zz>
References: <B495731E-C854-450B-943B-B96248B8F609@steelskies.com>
	<11926134961610-git-send-email-maillist@steelskies.com>
	<11926134961549-git-send-email-maillist@steelskies.com>
	<11926134961275-git-send-email-maillist@steelskies.com>
	<4715F2E6.1000708@viscovery.net>
	<6E65762D-FBC4-4A7C-97A9-20F6744E25DE@steelskies.com>
	<864pgpfyrd.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 22:03:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiF6L-0004mY-P2
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 22:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759613AbXJQUCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 16:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759380AbXJQUCR
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 16:02:17 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:36672 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757816AbXJQUCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 16:02:16 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IiF5s-00015k-4r
	for git@vger.kernel.org; Wed, 17 Oct 2007 16:02:16 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 919441C4D4B3; Wed, 17 Oct 2007 22:03:10 +0200 (CEST)
In-Reply-To: <864pgpfyrd.fsf@lola.quinscape.zz> (David Kastrup's message of "Wed\, 17 Oct 2007 19\:15\:50 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61423>

David Kastrup <dak@gnu.org> writes:

> Jonathan del Strother <maillist@steelskies.com> writes:
>
>> For instance, git_editor in git-sh-setup expects the editor path to be
>> pre-quoted.  So in t3404, you need to produce escaped double quotes &
>> dollar signs, resulting in unpleasantness like this :
>>
>> VISUAL="`pwd`/fake-editor.sh"
>> VISUAL=${VISUAL//\"/\\\"}
>> VISUAL=${VISUAL//$/\\\$}
>> VISUAL=\"$VISUAL\"
>> export VISUAL
>
> EDITORPWD="`pwd`"
> VISUAL='$EDITORPWD/fake-editor.sh'
> export EDITORPWD VISUAL

Pffffft.

VISUAL='"$EDITORPWD/fake-editor.sh"'

of course.  Or we still have problems with spaces in pwd.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
