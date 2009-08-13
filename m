From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] fast-import: define a new option command
Date: Thu, 13 Aug 2009 13:42:10 -0700
Message-ID: <7vhbwb5tul.fsf@alter.siamese.dyndns.org>
References: <1250140186-12363-2-git-send-email-srabbelier@gmail.com>
 <alpine.DEB.1.00.0908131652190.7429@intel-tinevez-2-302>
 <20090813150446.GM1033@spearce.org>
 <fabb9a1e0908130812s297ccfc6vd6b746daf1dcc69a@mail.gmail.com>
 <20090813152419.GN1033@spearce.org>
 <fabb9a1e0908130926qdc6cdf1ka7f2442421ce12ce@mail.gmail.com>
 <alpine.DEB.1.00.0908131907080.7429@intel-tinevez-2-302>
 <fabb9a1e0908131009j51c54cacp3f837f9b8525061@mail.gmail.com>
 <20090813172508.GO1033@spearce.org> <7vzla3bjn5.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0908131301g4361a06es98fbf3c256c25300@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 22:42:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbh87-0007Gq-FM
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 22:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217AbZHMUmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 16:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbZHMUmY
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 16:42:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60287 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbZHMUmX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 16:42:23 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5CA3428C86;
	Thu, 13 Aug 2009 16:42:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BE07F28C84; Thu, 13 Aug 2009
 16:42:12 -0400 (EDT)
In-Reply-To: <fabb9a1e0908131301g4361a06es98fbf3c256c25300@mail.gmail.com>
 (Sverre Rabbelier's message of "Thu\, 13 Aug 2009 13\:01\:16 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CD25548E-8849-11DE-8D52-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125870>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Thu, Aug 13, 2009 at 12:26, Junio C Hamano<gitster@pobox.com> wrote:
>> How about making the option parser get and keep the _name_ of the file
>> until option parsing session (i.e. read the stream until initial run of
>> "option" command runs out and then parse the command line to override),
>> and then finally open the file and read it?
>
> On Thu, Aug 13, 2009 at 10:44, Sverre Rabbelier<srabbelier@gmail.com> wrote:
>> Ah, then how about in option_import_marks() we only store the name of
>> the file, like in option_export_marks, and at the end, when we reach
>> the first non-option command (and we've parsed argv), we read the
>> file. That way it's only read once, and it deals with the above
>> scenario.
>
> Which is exactly what the latest version does :).

Heh, thanks; it appears I lagged behind by about 2 hours?
