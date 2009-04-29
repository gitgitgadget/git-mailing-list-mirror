From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git config: error when editing a repo config and not
 being in one
Date: Wed, 29 Apr 2009 16:22:53 -0700
Message-ID: <7v1vrb59ki.fsf@gitster.siamese.dyndns.org>
References: <1241043939-29013-1-git-send-email-felipe.contreras@gmail.com>
 <alpine.DEB.1.00.0904300043030.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Teemu Likonen <tlikonen@iki.fi>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 30 01:23:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzJ7P-00026x-HH
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 01:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969AbZD2XXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 19:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbZD2XXE
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 19:23:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46648 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbZD2XXC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 19:23:02 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 57C42AEAAC;
	Wed, 29 Apr 2009 19:23:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B3083AEAA9; Wed,
 29 Apr 2009 19:22:55 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0904300043030.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Thu, 30 Apr 2009 00:44:25 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AEA2D802-3514-11DE-AFC7-CABC03BA4B0C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117978>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 30 Apr 2009, Felipe Contreras wrote:
>
>> diff --git a/builtin-config.c b/builtin-config.c
>> index d8da72c..6e936e1 100644
>> --- a/builtin-config.c
>> +++ b/builtin-config.c
>> @@ -390,6 +390,8 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
>>  	}
>>  	else if (actions == ACTION_EDIT) {
>>  		check_argc(argc, 0, 0);
>> +		if (!config_exclusive_filename && !is_inside_git_dir())
>> +			die("not in a git directory");
>
> Why not use the nongit variable?

Good; makes a lot more sense.
