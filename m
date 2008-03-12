From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/5] git-submodule summary: show commit summary
Date: Tue, 11 Mar 2008 23:15:58 -0700
Message-ID: <7vmyp479i9.fsf@gitster.siamese.dyndns.org>
References: <1205243539-797-1-git-send-email-pkufranky@gmail.com>
 <1205243539-797-2-git-send-email-pkufranky@gmail.com>
 <1205243539-797-3-git-send-email-pkufranky@gmail.com>
 <7vabl48tt4.fsf@gitster.siamese.dyndns.org>
 <46dff0320803112128j23337873jf1fb12f5716151d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 07:17:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZKGo-0008B0-63
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 07:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbYCLGQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 02:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbYCLGQL
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 02:16:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbYCLGQK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 02:16:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6119B3D65;
	Wed, 12 Mar 2008 02:16:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 91F4B3D63; Wed, 12 Mar 2008 02:16:05 -0400 (EDT)
In-Reply-To: <46dff0320803112128j23337873jf1fb12f5716151d8@mail.gmail.com>
 (Ping Yin's message of "Wed, 12 Mar 2008 12:28:59 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76930>

"Ping Yin" <pkufranky@gmail.com> writes:

> On Wed, Mar 12, 2008 at 12:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> --- a/git-submodule.sh
>>  +++ b/git-submodule.sh
>>  @@ -400,7 +400,7 @@ cmd_summary() {
>>
>>                                 160000)
>>                                 sha1_dst=$(GIT_DIR="$name/.git" git rev-parse HEAD)
>>                                 ;;
>>  -                               100644)
>>  +                               100644 | 100755 | 120000)
>>
> Are 644 and 755 file permission bit? If it is, how about the other
> cases (655, 744 and so on)?

They never appear, as git tracks only one executable bit, so mode bits for
regular file blobs are canonicalized to either 100755 or 100644.

Don't you ever see 000000 mode bits here?  There is no case arm for that
in the code.
